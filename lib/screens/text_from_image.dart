import 'package:flutter/material.dart';

class TextFromImage extends StatelessWidget {
  const TextFromImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text from Image ✨'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Text from Image Screen'),
      ),
    );
  }
}
