import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OpenAIModelBuilderExample extends StatelessWidget {
  const OpenAIModelBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAIModelBuilder(
      modelId: "text-davinci-003",
      onSuccessBuilder: (BuildContext context, OpenAIModelModel model) {
        return Text("$model");
      },
      onLoadingBuilder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      onErrorBuilder: (context, err) {
        return Center(
          child: Text("$err"),
        );
      },
    );
  }
}
