import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OpenAIImageEditBuilder extends StatefulWidget {
  const OpenAIImageEditBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    required this.prompt,
    required this.image,
    this.mask,
    this.n,
    this.responseFormat,
    this.size,
    this.user,
    this.shouldRebuildOnStateUpdates = false,
  });

  final String prompt;

  final File image;

  final File? mask;

  final int? n;

  final OpenAIResponseFormat? responseFormat;

  final OpenAIImageSize? size;

  final String? user;

  final Widget Function(BuildContext context, OpenAiImageEditModel snapshot)
      onSuccessBuilder;

  final Widget Function(BuildContext context, Object error) onErrorBuilder;

  final Widget Function(BuildContext context) onLoadingBuilder;

  final bool shouldRebuildOnStateUpdates;

  @override
  State<OpenAIImageEditBuilder> createState() => _OpenAIImageEditBuilderState();
}

class _OpenAIImageEditBuilderState extends State<OpenAIImageEditBuilder> {
  late Future<OpenAiImageEditModel> future;

  @override
  void initState() {
    future = OpenAI.instance.image.edit(
      prompt: widget.prompt,
      image: widget.image,
      mask: widget.mask,
      n: widget.n,
      responseFormat: widget.responseFormat,
      size: widget.size,
      user: widget.user,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIImageEditBuilder oldWidget) {
    if (widget.shouldRebuildOnStateUpdates) {
      setState(() {
        future = OpenAI.instance.image.edit(
          prompt: widget.prompt,
          mask: widget.mask,
          image: widget.image,
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
    return FutureBuilder(
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
