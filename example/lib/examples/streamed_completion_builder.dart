import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class StreamedCompletionBuilderExample extends StatelessWidget {
  const StreamedCompletionBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAIStreamedCompletionBuilder(
      model: "text-davinci-003",
      prompt: "OpenAI is a",
      maxTokens: 50,
      shouldRebuildOnConfigChanged: true,
      onSuccessBuilder: (
        BuildContext context,
        OpenAIStreamCompletionModel model,
      ) {
        print(model.choices.first.text);
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
