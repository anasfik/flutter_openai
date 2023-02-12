import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class ImageGenerationBuilderExample extends StatelessWidget {
  const ImageGenerationBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenAIImageGenerationBuilder(
      prompt:
          "A dog and an astronaut in the desert watching the sky at night chilling",
      n: 4,
      size: OpenAIImageSize.size256,
      responseFormat: OpenAIResponseFormat.url,
      shouldRebuildOnConfigChanged: false,
      onSuccessBuilder: (context, snapshot) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Image.network(snapshot.data[index].url);
          },
        );
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
