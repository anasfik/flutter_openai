import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_openai/flutter_openai.dart';

import 'examples/models_builder.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  OpenAI.apiKey = dotenv.env["OPEN_AI_API_KEY"]!;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OpenAI Demo',
      home: ModelsBuilderExample(),
    );
  }
}
