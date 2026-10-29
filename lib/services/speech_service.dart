import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  bool get isListening => _speech.isListening;

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  Future<void> startListening({
    required Function(String text) onResult,
  }) async {
    await _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }
}