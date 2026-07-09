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

  LessonNodeState _stateFor(
    Lesson lesson,
    int index,
    ProgressProvider progress,
  ) {
    if (progress.isCompleted(lesson.id)) return LessonNodeState.completed;
    final previousLesson =
        index == 0 ? null : sampleUnit.lessons[index - 1];
    final unlocked = previousLesson == null || progress.isCompleted(previousLesson.id);
    return unlocked ? LessonNodeState.current : LessonNodeState.locked;
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('العربية معي'),
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
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.sidiBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sampleUnit.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.jasmine,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sampleUnit.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.jasmine.withOpacity(0.85),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            ...List.generate(sampleUnit.lessons.length, (i) {
              final lesson = sampleUnit.lessons[i];
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
        ),
      ),
    );
  }
}
