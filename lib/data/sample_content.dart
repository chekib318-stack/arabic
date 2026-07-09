import '../models/exercise.dart';
import '../models/lesson.dart';

/// وحدة تجريبية واحدة "الكلمات الأولى" تحتوي على 3 دروس و14 كلمة/جملة
/// كنموذج أولي (Placeholder) قابل للاستبدال لاحقًا بمحتوى تربوي حقيقي
/// عبر الاتصال بمنصة الوزارة (PHP/MySQL API).
final LearningUnit sampleUnit = LearningUnit(
  id: 'unit_01',
  title: 'الكلمات الأولى',
  description: 'أول خطوة في رحلتك مع العربية',
  lessons: [
    Lesson(
      id: 'lesson_01',
      title: 'الأشياء من حولي',
      icon: '🏠',
      xpReward: 20,
      exercises: const [
        Exercise(
          id: 'ex_01',
          type: ExerciseType.chooseImage,
          prompt: 'اختر الصورة المناسبة لكلمة: بيت',
          emoji: '🏠',
          options: ['🏠', '🚗', '📖', '🚪'],
          correctAnswer: '🏠',
        ),
        Exercise(
          id: 'ex_02',
          type: ExerciseType.chooseImage,
          prompt: 'اختر الصورة المناسبة لكلمة: قلم',
          emoji: '✏️',
          options: ['✏️', '🌹', '💧', '🐱'],
          correctAnswer: '✏️',
        ),
        Exercise(
          id: 'ex_03',
          type: ExerciseType.chooseImage,
          prompt: 'اختر الصورة المناسبة لكلمة: كتاب',
          emoji: '📖',
          options: ['🚗', '📖', '🌙', '🐟'],
          correctAnswer: '📖',
        ),
        Exercise(
          id: 'ex_04',
          type: ExerciseType.matchPairs,
          prompt: 'اضغط على الكلمة ثم على الصورة المطابقة لها',
          options: const ['باب', 'سيارة'],
          scrambledWords: const ['🚗', '🚪'], // مرتب عشوائيًا عمدًا
          pairAnswers: const ['🚪', '🚗'], // الإجابة الصحيحة مقابل كل عنصر في options بالترتيب
          correctAnswer: '',
        ),
      ],
    ),
    Lesson(
      id: 'lesson_02',
      title: 'الطبيعة من حولي',
      icon: '☀️',
      xpReward: 25,
      exercises: const [
        Exercise(
          id: 'ex_05',
          type: ExerciseType.listenChoose,
          prompt: 'استمع ثم اختر الكلمة الصحيحة',
          targetWord: 'شمس',
          options: ['شمس', 'قمر', 'ماء'],
          correctAnswer: 'شمس',
        ),
        Exercise(
          id: 'ex_06',
          type: ExerciseType.listenChoose,
          prompt: 'استمع ثم اختر الكلمة الصحيحة',
          targetWord: 'قمر',
          options: ['وردة', 'قمر', 'تفاحة'],
          correctAnswer: 'قمر',
        ),
        Exercise(
          id: 'ex_07',
          type: ExerciseType.chooseImage,
          prompt: 'اختر الصورة المناسبة لكلمة: ماء',
          emoji: '💧',
          options: ['💧', '🌹', '🍎', '🐱'],
          correctAnswer: '💧',
        ),
        Exercise(
          id: 'ex_08',
          type: ExerciseType.chooseImage,
          prompt: 'اختر الصورة المناسبة لكلمة: وردة',
          emoji: '🌹',
          options: ['🐟', '🌹', '🚪', '📖'],
          correctAnswer: '🌹',
        ),
        Exercise(
          id: 'ex_09',
          type: ExerciseType.fillBlank,
          prompt: 'أكمل الجملة: الــــ مشرقة في السماء',
          targetWord: 'الشمس مشرقة في السماء',
          options: ['الشمس', 'القمر', 'الماء'],
          correctAnswer: 'الشمس',
        ),
      ],
    ),
    Lesson(
      id: 'lesson_03',
      title: 'جملتي الأولى',
      icon: '📝',
      xpReward: 30,
      exercises: const [
        Exercise(
          id: 'ex_10',
          type: ExerciseType.chooseImage,
          prompt: 'اختر الصورة المناسبة لكلمة: قطة',
          emoji: '🐱',
          options: ['🐱', '🐟', '🍎', '🚗'],
          correctAnswer: '🐱',
        ),
        Exercise(
          id: 'ex_11',
          type: ExerciseType.chooseImage,
          prompt: 'اختر الصورة المناسبة لكلمة: سمكة',
          emoji: '🐟',
          options: ['🐱', '🐟', '🌹', '📖'],
          correctAnswer: '🐟',
        ),
        Exercise(
          id: 'ex_12',
          type: ExerciseType.arrangeWords,
          prompt: 'رتب الكلمات لتكوين جملة صحيحة',
          targetWord: 'هذا بيت',
          scrambledWords: const ['بيت', 'هذا'],
          correctAnswer: 'هذا بيت',
        ),
        Exercise(
          id: 'ex_13',
          type: ExerciseType.arrangeWords,
          prompt: 'رتب الكلمات لتكوين جملة صحيحة',
          targetWord: 'الشمس مشرقة',
          scrambledWords: const ['مشرقة', 'الشمس'],
          correctAnswer: 'الشمس مشرقة',
        ),
        Exercise(
          id: 'ex_14',
          type: ExerciseType.fillBlank,
          prompt: 'أكمل الجملة: القطة تأكل ال ـــــ',
          targetWord: 'القطة تأكل السمكة',
          options: ['السمكة', 'الوردة', 'الكتاب'],
          correctAnswer: 'السمكة',
        ),
      ],
    ),
  ],
);
