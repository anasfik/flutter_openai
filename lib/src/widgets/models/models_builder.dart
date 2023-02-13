import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

import '../base/future_builder.dart';

class OpenAIModelsBuilder extends StatefulWidget {
  const OpenAIModelsBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    this.shouldRebuildOnStateUpdates = false,
  });

  final Widget Function(BuildContext context, List<OpenAIModelModel> models)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final bool shouldRebuildOnStateUpdates;

  @override
  State<OpenAIModelsBuilder> createState() => _OpenAIModelsBuilderState();
}

class _OpenAIModelsBuilderState extends State<OpenAIModelsBuilder> {
  late Future<List<OpenAIModelModel>> future = OpenAI.instance.model.list();

  @override
  void didUpdateWidget(covariant OpenAIModelsBuilder oldWidget) {
    if (widget.shouldRebuildOnStateUpdates) {
      setState(() {
        future = OpenAI.instance.model.list();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<List<OpenAIModelModel>>(
      future: future,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<OpenAIModelModel>> modelsSnapshot,
      ) {
        if (modelsSnapshot.hasData) {
          return widget.onSuccessBuilder(context, modelsSnapshot.data!);
        } else if (modelsSnapshot.hasError) {
          return widget.onErrorBuilder(context, modelsSnapshot.error!);
        } else if (modelsSnapshot.connectionState == ConnectionState.waiting) {
          return widget.onLoadingBuilder(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
