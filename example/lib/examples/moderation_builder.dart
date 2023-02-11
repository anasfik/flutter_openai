import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class ModerationBuilderExample extends StatelessWidget {
  const ModerationBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAIModerationBuilder(
      input: 'I will kill you, I hate you stupid',
      onSuccessBuilder: (BuildContext context, OpenAIModerationModel model) {
        return Center(
          child: Text(model.results.first.categories.toString()),
        );
      },
      onErrorBuilder: (BuildContext context, Object error) {
        return Center(
          child: Text(error.toString()),
        );
      },
      onLoadingBuilder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
