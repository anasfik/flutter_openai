import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

class OpenAIEmbeddingBuilder extends StatefulWidget {
  const OpenAIEmbeddingBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    this.shouldRebuildOnStateUpdates = false,
    required this.input,
    required this.model,
    this.user,
  });

  final Widget Function(BuildContext context, OpenAIEmbeddingsModel model)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final bool shouldRebuildOnStateUpdates;
  final String model;
  final String input;
  final String? user;

  @override
  State<OpenAIEmbeddingBuilder> createState() => _OpenAIEmbeddingBuilderState();
}

class _OpenAIEmbeddingBuilderState extends State<OpenAIEmbeddingBuilder> {
  late Future<OpenAIEmbeddingsModel> future;

  @override
  void initState() {
    future = OpenAI.instance.embedding.create(
      model: widget.model,
      input: widget.input,
      user: widget.user,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIEmbeddingBuilder oldWidget) {
    if (widget.shouldRebuildOnStateUpdates) {
      setState(() {
        future = OpenAI.instance.embedding.create(
          input: widget.input,
          model: widget.model,
          user: widget.user,
        );
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OpenAIEmbeddingsModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return widget.onSuccessBuilder(context, snapshot.data!);
        } else if (snapshot.hasError) {
          return widget.onErrorBuilder(context, snapshot.error!);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.onLoadingBuilder(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
