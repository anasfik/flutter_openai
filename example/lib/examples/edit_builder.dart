import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class EditBuilderExample extends StatelessWidget {
  const EditBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAIEditBuilder(
      model: 'text-davinci-edit-001',
      instruction: 'remove ! from the input',
      input: "!!cs!fvsnvibvvsf!sb!d!b!tdnd!nd!ndn!dnjd",
      temperature: 0.7,
      n: 1,
      onSuccessBuilder: (context, model) {
        return Text(model.choices.first.text);
      },
      onErrorBuilder: (context, error) {
        return Text(error.toString());
      },
      onLoadingBuilder: (context) {
        return const CircularProgressIndicator();
      },
    );
  }
}
