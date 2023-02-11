import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

import '../base/future_builder.dart';

class OpenAIModelBuilder extends StatefulWidget {
  const OpenAIModelBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    required this.modelId,
    this.shouldRebuildOnConfigChanged = false,
  });

  final Widget Function(BuildContext context, OpenAIModelModel model)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final String modelId;
  final bool shouldRebuildOnConfigChanged;

  @override
  State<OpenAIModelBuilder> createState() => _OpenAIModelBuilderState();
}

class _OpenAIModelBuilderState extends State<OpenAIModelBuilder> {
  late Future<OpenAIModelModel> future;

  @override
  void initState() {
    future = OpenAI.instance.model.retrieve(widget.modelId);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIModelBuilder oldWidget) {
    if (widget.modelId != oldWidget.modelId) {
      if (widget.shouldRebuildOnConfigChanged) {
        setState(() {
          future = OpenAI.instance.model.retrieve(widget.modelId);
        });
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<OpenAIModelModel>(
      future: future,
      shouldRebuildOnConfigChanged: widget.shouldRebuildOnConfigChanged,
      builder: (
        BuildContext context,
        AsyncSnapshot<OpenAIModelModel> modelSnapshot,
      ) {
        if (modelSnapshot.hasData) {
          return widget.onSuccessBuilder(context, modelSnapshot.data!);
        } else if (modelSnapshot.hasError) {
          return widget.onErrorBuilder(context, modelSnapshot.error!);
        } else if (modelSnapshot.connectionState == ConnectionState.waiting) {
          return widget.onLoadingBuilder(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
