import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:provider/provider.dart';

class TextFromTextScreen extends StatelessWidget {
  const TextFromTextScreen({super.key});
  static final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);
    return PopScope(
      onPopInvokedWithResult: (val, res) async {
        geminiProvider.reset();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text from Text ✨'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your prompt here...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        geminiProvider.generateContentFromText(
                            prompt: _textController.text);
                      },
                      icon: const Icon(Icons.send),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              geminiProvider.isLoading
                  ? const CircularProgressIndicator()
                  : geminiProvider.response != null
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Text(geminiProvider.response!),
                          ),
                        )
                      : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
