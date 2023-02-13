import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class StreamedCompletionBuilderExample extends StatefulWidget {
  const StreamedCompletionBuilderExample({super.key});

  @override
  State<StreamedCompletionBuilderExample> createState() =>
      _StreamedCompletionBuilderExampleState();
}

class _StreamedCompletionBuilderExampleState
    extends State<StreamedCompletionBuilderExample> {
  late TextEditingController _controller;
  late String result;
  @override
  void initState() {
    _controller = TextEditingController(text: "OpenAI is ");
    result = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shouldRebuild = true;

    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (shouldRebuild) {
                  result = "";
                  setState(() {});
                }
              },
              child: const Text("Go"),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        OpenAIStreamedCompletionBuilder(
          model: "text-davinci-003",
          prompt: _controller.text,
          maxTokens: 100,
          shouldRebuildOnConfigChanged: shouldRebuild,
          onSuccessBuilder: (
            BuildContext context,
            OpenAIStreamCompletionModel model,
          ) {
            print(model.choices.first.text);
            result += model.choices.first.text;
            return Text(result);
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
      ],
    );
  }
}
