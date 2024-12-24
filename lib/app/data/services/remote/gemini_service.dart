import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey = 'AIzaSyAb_rC9EgQDjbVPUAoQ0mSEdHNNk_mnWPI';
  late GenerativeModel _model;

  GeminiService() {
    _initializeModel();
  }

  void _initializeModel() {
    _model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  }

  Future<String> generateContent(String prompt, String data) async {
    try {
      final content = [Content.text(prompt),Content.text(data)];
      final result = await _model.generateContent(content);
      return result.text ?? 'No response received.';
    } catch (e) {
      throw Exception('Error generating content: $e');
    }
  }
}
