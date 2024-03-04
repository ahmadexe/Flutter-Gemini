import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  GeminiService({
    required this.model,
  });

  final GenerativeModel model;

  Future<String?> generateContentFromText({
    required String prompt,
  }) async {
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text;
  }

  Future<String?> generateContentFromImage(
      {required String prompt, required DataPart dataPart}) async {

    final text = TextPart(prompt);
    final response = await model.generateContent([
      Content.multi([text, dataPart])
    ]);

    return response.text;
  }
}
