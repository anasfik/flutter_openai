import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OpenAIImageGenerationBuilder extends StatefulWidget {
  const OpenAIImageGenerationBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    required this.prompt,
    this.n,
    this.responseFormat,
    this.size,
    this.user,
    this.shouldRebuildOnStateUpdates = false,
  });

  final String prompt;

  final int? n;

  final OpenAIResponseFormat? responseFormat;

  final OpenAIImageSize? size;

  final String? user;

  final Widget Function(BuildContext context, OpenAIImageModel snapshot)
      onSuccessBuilder;

  final Widget Function(BuildContext context, Object error) onErrorBuilder;

  final Widget Function(BuildContext context) onLoadingBuilder;

  final bool shouldRebuildOnStateUpdates;

  @override
  State<OpenAIImageGenerationBuilder> createState() =>
      _OpenAIImageGenerationBuilderState();
}

class _OpenAIImageGenerationBuilderState
    extends State<OpenAIImageGenerationBuilder> {
  late Future<OpenAIImageModel> future;

  @override
  void initState() {
    future = OpenAI.instance.image.create(
      prompt: widget.prompt,
      n: widget.n,
      responseFormat: widget.responseFormat,
      size: widget.size,
      user: widget.user,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIImageGenerationBuilder oldWidget) {
    if (widget.shouldRebuildOnStateUpdates) {
      setState(() {
        future = OpenAI.instance.image.create(
          prompt: widget.prompt,
          n: widget.n,
          responseFormat: widget.responseFormat,
          size: widget.size,
          user: widget.user,
        );
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OpenAIImageModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return widget.onErrorBuilder(context, snapshot.error!);
        } else if (snapshot.hasData) {
          return widget.onSuccessBuilder(context, snapshot.data!);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.onLoadingBuilder(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
