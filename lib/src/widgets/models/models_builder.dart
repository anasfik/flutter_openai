import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OpenAIModelsBuilder extends StatelessWidget {
  const OpenAIModelsBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
  });

  final Widget Function(BuildContext context, List<OpenAIModelModel> models)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OpenAIModelModel>>(
      future: OpenAI.instance.model.list(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<OpenAIModelModel>> modelsSnapshot,
      ) {
        if (modelsSnapshot.hasData) {
          return onSuccessBuilder(context, modelsSnapshot.data!);
        } else if (modelsSnapshot.hasError) {
          return onErrorBuilder(context, modelsSnapshot.error!);
        } else if (modelsSnapshot.connectionState == ConnectionState.waiting) {
          return onLoadingBuilder(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}