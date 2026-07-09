import 'package:flutter_tts/flutter_tts.dart';

/// خدمة تشغيل الصوت للمفردات والجمل عبر محرك تحويل النص إلى كلام (TTS)
/// المدمج في نظام التشغيل (Android/iOS). هذا يفادي الحاجة لتسجيل آلاف
/// الملفات الصوتية يدويا في نسخة البداية، ويشتغل تلقائيا لأي كلمة جديدة
/// تُضاف للمحتوى دون أي عمل إضافي.
///
/// ملاحظة: يستعمل عربية فصحى (locale 'ar') بشكل ثابت — لا محاولة للهجات
/// محلية، بناء على طلب صريح بإبقاء النطق فصيحا وواضحا.
///
/// خارطة الطريق: في مرحلة لاحقة، حين تتوفر تسجيلات حقيقية بصوت بشري
/// (مرفوعة على خادم PHP)، تُستبدل مكالمة [speak] بمنطق:
///   1. تحقق هل توجد ملف صوتي حقيقي لهذه الكلمة على الخادم/محليا
///   2. إن وُجد: شغّله عبر audioplayers
///   3. إن لم يوجد بعد: استعمل TTS كبديل احتياطي (fallback)
/// هذا يسمح بالانتقال التدريجي كلمة بكلمة بلا كسر أي شيء.
class AudioService {
  AudioService._internal() {
    _init();
  }

  static final AudioService instance = AudioService._internal();
  final FlutterTts _tts = FlutterTts();
  bool _ready = false;

  static const double _defaultPitch = 1.0;
  static const double _defaultRate = 0.42;

  Future<void> _init() async {
    await _tts.setLanguage('ar'); // عربية فصحى، بدون محاولة لهجات محلية
    await _tts.setSpeechRate(_defaultRate); // أبطأ قليلا لملاءمة المتعلمين الصغار
    await _tts.setPitch(_defaultPitch);
    await _tts.awaitSpeakCompletion(true); // ينتظر speak() حتى ينتهي النطق فعليا
    _ready = true;
  }

  /// ينطق نصا عربيا. آمن الاستدعاء حتى قبل اكتمال التهيئة (سينتظر تلقائيا).
  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    if (!_ready) await _init();
    await _tts.stop();
    await _tts.speak(text);
  }

  /// تعليق تحفيزي عند الإجابة الصحيحة، بنبرة مرحة أعلى قليلا من المعتاد.
  Future<void> speakCorrect() async {
    if (!_ready) await _init();
    await _tts.stop();
    await _tts.setPitch(1.15);
    await _tts.speak('أحسنت، برافو عليك');
    await _tts.setPitch(_defaultPitch);
  }

  /// تعليق عند الإجابة الخاطئة، بنبرة أهدأ وأبطأ قليلا (نغمة حزينة لطيفة)
  /// دون أن تكون محبطة للمتعلم الصغير.
  Future<void> speakWrong() async {
    if (!_ready) await _init();
    await _tts.stop();
    await _tts.setPitch(0.82);
    await _tts.setSpeechRate(0.36);
    await _tts.speak('خطأ، حاول مرة أخرى');
    await _tts.setPitch(_defaultPitch);
    await _tts.setSpeechRate(_defaultRate);
  }

  Future<void> stop() => _tts.stop();
}
