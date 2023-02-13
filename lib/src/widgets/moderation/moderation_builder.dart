import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

class OpenAIModerationBuilder extends StatefulWidget {
  const OpenAIModerationBuilder({
    super.key,
    required this.input,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    this.model,
    this.shouldRebuildOnConfigChanged = false,
  });

  final Widget Function(BuildContext context, OpenAIModerationModel model)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final bool shouldRebuildOnConfigChanged;
  final String input;
  final String? model;
  @override
  State<OpenAIModerationBuilder> createState() =>
      _OpenAIModerationBuilderState();
}

class _OpenAIModerationBuilderState extends State<OpenAIModerationBuilder> {
  late Future<OpenAIModerationModel> future;

  @override
  void initState() {
    future = OpenAI.instance.moderation.create(
      input: widget.input,
      model: widget.model,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIModerationBuilder oldWidget) {
    if (widget.shouldRebuildOnConfigChanged) {
      future = OpenAI.instance.moderation.create(
        input: widget.input,
        model: widget.model,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context,
          AsyncSnapshot<OpenAIModerationModel> snapshot) {
        if (snapshot.hasData) {
          return widget.onSuccessBuilder(context, snapshot.data!);
        } else if (snapshot.hasError) {
          return widget.onErrorBuilder(context, snapshot.error!);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.onLoadingBuilder(context);
        } else {
          return widget.onLoadingBuilder(context);
        }
      },
    );
  }
}
