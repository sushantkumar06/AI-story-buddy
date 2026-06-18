import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class TtsService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> initialize({
    required VoidCallback onComplete,
    required VoidCallback onError,
  }) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.45);

    flutterTts.setCompletionHandler(onComplete);

    flutterTts.setErrorHandler((message) {
      onError();
    });
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
