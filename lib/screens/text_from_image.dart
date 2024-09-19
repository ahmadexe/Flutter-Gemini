import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:provider/provider.dart';

class TextFromImage extends StatelessWidget {
  const TextFromImage({super.key});

  static final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);
    final mediaProvider = Provider.of<MediaProvider>(context);

    return PopScope(
      onPopInvokedWithResult: (val, res) async {
        mediaProvider.reset();
        geminiProvider.reset();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text from Image ✨'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  mediaProvider.bytes == null
                      ? IconButton(
                          onPressed: () {
                            mediaProvider.setImage();
                          },
                          icon: const Icon(Icons.add),
                        )
                      : Image.memory(
                          mediaProvider.bytes!,
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your prompt here...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (mediaProvider.bytes != null)
                    ElevatedButton(
                      onPressed: () {
                        geminiProvider.generateContentFromImage(
                          prompt: _textController.text,
                          bytes: mediaProvider.bytes!,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Generate'),
                    ),
                  const SizedBox(height: 16),
                  geminiProvider.isLoading
                      ? const CircularProgressIndicator()
                      : Text(geminiProvider.response ?? ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
