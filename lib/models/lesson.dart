import 'exercise.dart';

/// الدرس: وحدة تعلم صغيرة مدتها 3-5 دقائق ضمن مسار أكبر (مثلاً: الحروف)
class Lesson {
  final String id;
  final String title;
  final String icon; // رمز تعبيري يمثل موضوع الدرس
  final List<Exercise> exercises;
  final int xpReward;

  const Lesson({
    required this.id,
    required this.title,
    required this.icon,
    required this.exercises,
    this.xpReward = 20,
  });
}

/// المسار التعليمي: تجميعة دروس متدرجة (الحروف، الحركات، الكلمات...)
class LearningUnit {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;

  const LearningUnit({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });
}
