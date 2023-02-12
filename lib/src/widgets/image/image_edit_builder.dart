import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OPenAIImageEditBuilder extends StatefulWidget {
  const OPenAIImageEditBuilder({
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
    this.shouldRebuildOnConfigChanged = false,
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

  final bool shouldRebuildOnConfigChanged;

  @override
  State<OPenAIImageEditBuilder> createState() => _OPenAIImageEditBuilderState();
}

class _OPenAIImageEditBuilderState extends State<OPenAIImageEditBuilder> {
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
  void didUpdateWidget(covariant OPenAIImageEditBuilder oldWidget) {
    if (oldWidget.prompt != widget.prompt ||
        oldWidget.mask != widget.mask ||
        oldWidget.image != widget.image ||
        oldWidget.n != widget.n ||
        oldWidget.responseFormat != widget.responseFormat ||
        oldWidget.size != widget.size ||
        oldWidget.user != widget.user) {
      if (widget.shouldRebuildOnConfigChanged) {
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
