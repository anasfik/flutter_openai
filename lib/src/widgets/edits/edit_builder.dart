import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

class OpenAIEditBuilder extends StatefulWidget {
  const OpenAIEditBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    required this.onLoadingBuilder,
    required this.model,
    this.instruction,
    this.temperature,
    this.topP,
    this.input,
    this.n,
    this.shouldRebuildOnConfigChanged = false,
  });

  final Widget Function(BuildContext context, OpenAIEditModel model)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final String? instruction;
  final String model;
  final double? temperature;
  final double? topP;
  final String? input;
  final int? n;
  final bool shouldRebuildOnConfigChanged;

  @override
  State<OpenAIEditBuilder> createState() => _OpenAIEditBuilderState();
}

class _OpenAIEditBuilderState extends State<OpenAIEditBuilder> {
  late Future<OpenAIEditModel> future;

  @override
  void initState() {
    future = OpenAI.instance.edit.create(
      instruction: widget.instruction,
      model: widget.model,
      temperature: widget.temperature,
      topP: widget.topP,
      input: widget.input,
      n: widget.n,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIEditBuilder oldWidget) {
    if (oldWidget.instruction != widget.instruction ||
        oldWidget.model != widget.model ||
        oldWidget.temperature != widget.temperature ||
        oldWidget.topP != widget.topP ||
        oldWidget.input != widget.input ||
        oldWidget.n != widget.n) {
      if (widget.shouldRebuildOnConfigChanged) {
        setState(() {
          future = OpenAI.instance.edit.create(
            instruction: widget.instruction,
            model: widget.model,
            temperature: widget.temperature,
            topP: widget.topP,
            input: widget.input,
            n: widget.n,
          );
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OpenAIEditModel>(
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
