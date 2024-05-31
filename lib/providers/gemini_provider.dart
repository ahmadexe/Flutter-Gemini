import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/services/gemini_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProvider extends ChangeNotifier {
  static GenerativeModel _initModel() {
    //const key = String.fromEnvironment('GEMINI_API_KEY');
    final key = dotenv.env['GEMINI_API_KEY'];

    if (key!.isEmpty) {
      throw Exception('GEMINI_API_KEY not found');
    }
    return GenerativeModel(model: 'gemini-1.5-flash', apiKey: key);
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

  Future<void> generateContentFromImage({
    required String prompt,
    required Uint8List bytes,
  }) async {
    isLoading = true;
    notifyListeners();
    response = null;
    final dataPart = DataPart(
      'image/jpeg',
      bytes,
    );

    response = await _geminiService.generateContentFromImage(
      prompt: prompt,
      dataPart: dataPart,
    );

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    response = null;
    isLoading = false;
    notifyListeners();
  }
}
