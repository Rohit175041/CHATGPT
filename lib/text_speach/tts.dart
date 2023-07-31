import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

class ttsspeach {
  static stop() async {
    await flutterTts.stop();
    return ;
  }

  static  speak(String text) async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setPitch(1.18);
    await flutterTts.speak(text).whenComplete(() {
      stop();
      print("Speak completed");
    });

  }
}
