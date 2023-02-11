import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class EmbeddingsBuilderExample extends StatelessWidget {
  const EmbeddingsBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAIEmbeddingBuilder(
      input: 'Hello World',
      model: 'text-embedding-ada-002',
      onSuccessBuilder: (BuildContext context, OpenAIEmbeddingsModel model) {
        return Center(
          child: Text(model.data.toString()),
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
