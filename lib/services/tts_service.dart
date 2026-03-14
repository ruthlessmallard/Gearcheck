import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(0.9);
    await _tts.setVolume(1.0);
    _initialized = true;
  }

  Future<void> speak(String text) async {
    await init();
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  String buildPhrase(String categoryName, String item) {
    if (categoryName == 'Travel Home') {
      if (item.toLowerCase() == 'drive safe') {
        return 'Remember to drive safely';
      }
      if (item.toLowerCase().contains('mine belt')) {
        return 'Remember your mine belt';
      }
      return 'Time to $item';
    }
    return 'Please check your $item';
  }
}
