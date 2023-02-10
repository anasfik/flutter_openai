import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

class OpenAIModelBuilder extends StatelessWidget {
  const OpenAIModelBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    required this.modelId,
  });

  final Widget Function(BuildContext context, OpenAIModelModel model)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final String modelId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OpenAIModelModel>(
      future: OpenAI.instance.model.retrieve(modelId),
      builder: (
        BuildContext context,
        AsyncSnapshot<OpenAIModelModel> modelSnapshot,
      ) {
        if (modelSnapshot.hasData) {
          return onSuccessBuilder(context, modelSnapshot.data!);
        } else if (modelSnapshot.hasError) {
          return onErrorBuilder(context, modelSnapshot.error!);
        } else if (modelSnapshot.connectionState == ConnectionState.waiting) {
          return onLoadingBuilder(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
