import 'package:flutter/material.dart';
import 'package:flutter_gemini/services/gemini_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProvider extends ChangeNotifier {
  static GenerativeModel _initModel() {
    const key = String.fromEnvironment('GEMINI_API_KEY');
    if (key.isEmpty) {
      throw Exception('GEMINI_API_KEY not found');
    }
    return GenerativeModel(model: 'gemini-pro', apiKey: key);
  }

  static final _geminiService = GeminiService(model: _initModel());

  String? response;
  bool isLoading = false;

  Future<void> generateContentFromText({
    required String prompt,
  }) async {
    isLoading = true;
    notifyListeners();
    response = null;
    response = await _geminiService.generateContentFromText(prompt: prompt);
    isLoading = false;
    notifyListeners();
  }
}
