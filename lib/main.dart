import 'package:flutter/material.dart';
import 'package:flutter_gemini/providers/gemini_provider.dart';
import 'package:flutter_gemini/providers/media_provider.dart';
import 'package:flutter_gemini/screens/dashboard.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GeminiProvider()),
        ChangeNotifierProvider(create: (context) => MediaProvider()),
      ],
      child: const MaterialApp(
        title: 'Gemini ✨',
        home: DashboardScreen(),
      ),
    );
  }
}
