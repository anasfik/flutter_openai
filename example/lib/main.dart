import 'package:example/view/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_openai/flutter_openai.dart';

import 'examples/models_builder.dart';
import 'models/screen_entity.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  OpenAI.apiKey = dotenv.env["OPEN_AI_API_KEY"]!;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Flutter OpenAI Demo',
      home: const MainScaffold(),
    );
  }
}

final ThemeData theme = ThemeData.light().copyWith(
  primaryColor: Colors.black87,
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.black87,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,
    elevation: 0,
  ),
);
