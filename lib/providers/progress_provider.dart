import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// يدير تقدم المتعلم محليًا (XP، الشارات، السلسلة اليومية، الدروس المكتملة).
/// هذا تخزين محلي مؤقت لنسخة البداية؛ في مرحلة لاحقة تتم مزامنته
/// مع الخادم (PHP/MySQL) عبر REST API حين تتوفر بنية تحتية للحساب المركزي.
class ProgressProvider extends ChangeNotifier {
  int xp = 0;
  int streakDays = 0;
  DateTime? lastActivityDate;
  final Set<String> completedLessonIds = {};

  static const _keyXp = 'xp';
  static const _keyStreak = 'streak';
  static const _keyLastActivity = 'last_activity';
  static const _keyCompleted = 'completed_lessons';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    xp = prefs.getInt(_keyXp) ?? 0;
    streakDays = prefs.getInt(_keyStreak) ?? 0;
    final lastActivityStr = prefs.getString(_keyLastActivity);
    lastActivityDate =
        lastActivityStr != null ? DateTime.tryParse(lastActivityStr) : null;
    completedLessonIds
      ..clear()
      ..addAll(prefs.getStringList(_keyCompleted) ?? []);
    notifyListeners();
  }

  Future<void> completeLesson(String lessonId, int xpReward) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (lastActivityDate != null) {
      final lastDay = DateTime(
        lastActivityDate!.year,
        lastActivityDate!.month,
        lastActivityDate!.day,
      );
      final diff = today.difference(lastDay).inDays;
      if (diff == 1) {
        streakDays += 1; // يوم متتالٍ جديد
      } else if (diff > 1) {
        streakDays = 1; // انقطعت السلسلة، تبدأ من جديد
      }
      // diff == 0: نفس اليوم، لا تغيير على السلسلة
    } else {
      streakDays = 1; // أول نشاط على الإطلاق
    }

    lastActivityDate = today;
    xp += xpReward;
    completedLessonIds.add(lessonId);

    await prefs.setInt(_keyXp, xp);
    await prefs.setInt(_keyStreak, streakDays);
    await prefs.setString(_keyLastActivity, today.toIso8601String());
    await prefs.setStringList(_keyCompleted, completedLessonIds.toList());

    notifyListeners();
  }

  bool isCompleted(String lessonId) => completedLessonIds.contains(lessonId);
}
