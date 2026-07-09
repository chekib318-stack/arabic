import 'package:flutter_tts/flutter_tts.dart';

/// خدمة تشغيل الصوت للمفردات والجمل عبر محرك تحويل النص إلى كلام (TTS)
/// المدمج في نظام التشغيل (Android/iOS). هذا يفادي الحاجة لتسجيل آلاف
/// الملفات الصوتية يدويا في نسخة البداية، ويشتغل تلقائيا لأي كلمة جديدة
/// تُضاف للمحتوى دون أي عمل إضافي.
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

  Future<void> _init() async {
    await _tts.setLanguage('ar');
    await _tts.setSpeechRate(0.42); // أبطأ قليلا لملاءمة المتعلمين الصغار
    await _tts.setPitch(1.0);
    _ready = true;
  }

  /// ينطق نصا عربيا. آمن الاستدعاء حتى قبل اكتمال التهيئة (سينتظر تلقائيا).
  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    if (!_ready) await _init();
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() => _tts.stop();
}
