import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class CompletionBuilderExample extends StatelessWidget {
  const CompletionBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAICompletionBuilder(
      model: "text-davinci-003",
      prompt: "OpenAI ",
      shouldRebuildOnConfigChanged: false,
      onSuccessBuilder: (BuildContext context, OpenAICompletionModel model) {
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
    );
  }
}
