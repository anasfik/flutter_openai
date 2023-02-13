import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class CompletionBuilderExample extends StatefulWidget {
  const CompletionBuilderExample({super.key});

  @override
  State<CompletionBuilderExample> createState() =>
      _CompletionBuilderExampleState();
}

class _CompletionBuilderExampleState extends State<CompletionBuilderExample> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: "OpenAI is ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("Go"),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: OpenAICompletionBuilder(
            model: "text-davinci-003",
            prompt: _controller.text,
            shouldRebuildOnStateUpdates: true,
            maxTokens: 50,
            temperature: 0.5,
            onSuccessBuilder:
                (BuildContext context, OpenAICompletionModel model) {
              return Text(model.choices.first.text);
            },
            onLoadingBuilder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            onErrorBuilder: (context, error) {
              return Text(error.toString());
            },
          ),
        ),
      ],
    );
  }
}
