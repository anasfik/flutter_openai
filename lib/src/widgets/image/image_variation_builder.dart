import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OpenAIImageVariationBuilder extends StatefulWidget {
  const OpenAIImageVariationBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    required this.image,
    this.n,
    this.responseFormat,
    this.size,
    this.user,
    this.shouldRebuildOnConfigChanged = false,
  });

  final File image;
  final int? n;
  final OpenAIResponseFormat? responseFormat;
  final OpenAIImageSize? size;
  final String? user;
  final Widget Function(
          BuildContext context, OpenAIImageVariationModel snapshot)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final bool shouldRebuildOnConfigChanged;

  @override
  State<OpenAIImageVariationBuilder> createState() =>
      _OpenAIImageVariationBuilderState();
}

class _OpenAIImageVariationBuilderState
    extends State<OpenAIImageVariationBuilder> {
  late Future<OpenAIImageVariationModel> future;

  @override
  void initState() {
    future = OpenAI.instance.image.variation(
      image: widget.image,
      n: widget.n,
      responseFormat: widget.responseFormat,
      size: widget.size,
      user: widget.user,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIImageVariationBuilder oldWidget) {

      if (widget.shouldRebuildOnConfigChanged) {
        future = OpenAI.instance.image.variation(
          image: widget.image,
          n: widget.n,
          responseFormat: widget.responseFormat,
          size: widget.size,
          user: widget.user,
        );
      
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OpenAIImageVariationModel>(
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
