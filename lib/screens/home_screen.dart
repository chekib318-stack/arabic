import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/sample_content.dart';
import '../models/lesson.dart';
import '../providers/progress_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/lesson_node.dart';
import '../widgets/stat_pill.dart';
import 'lesson_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// كل الدروس مرتبة عبر كل الوحدات، لحساب القفل/الفتح بشكل متسلسل
  /// حتى عبر حدود الوحدات (آخر درس في وحدة يفتح أول درس في الوحدة التالية)
  List<Lesson> get _allLessons =>
      kindergartenUnits.expand((unit) => unit.lessons).toList();

  LessonNodeState _stateFor(
    Lesson lesson,
    int globalIndex,
    ProgressProvider progress,
  ) {
    if (progress.isCompleted(lesson.id)) return LessonNodeState.completed;
    final lessons = _allLessons;
    final previousLesson = globalIndex == 0 ? null : lessons[globalIndex - 1];
    final unlocked = previousLesson == null || progress.isCompleted(previousLesson.id);
    return unlocked ? LessonNodeState.current : LessonNodeState.locked;
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    final lessons = _allLessons;
    int globalIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تعليم العربية — تحضيري'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                StatPill(icon: '🔥', value: '${progress.streakDays}', color: AppColors.ochre),
                const SizedBox(width: 8),
                StatPill(icon: '⭐', value: '${progress.xp}', color: AppColors.zellige),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          children: [
            for (final unit in kindergartenUnits) ...[
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.sidiBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          unit.title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.jasmine,
                              ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.jasmine.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            unit.gradeLevel,
                            style: const TextStyle(
                              color: AppColors.jasmine,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      unit.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.jasmine.withOpacity(0.85),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              ...unit.lessons.map((lesson) {
                final i = globalIndex++;
                final state = _stateFor(lesson, i, progress);
                final alignRight = i.isOdd;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Row(
                    mainAxisAlignment:
                        alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      LessonNode(
                        icon: lesson.icon,
                        title: lesson.title,
                        state: state,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => LessonScreen(lesson: lesson),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
