import 'package:flutter/material.dart';
import 'package:flutter_openai/flutter_openai.dart';

import '../base/future_builder.dart';

class OpenAICompletionBuilder extends StatefulWidget {
  const OpenAICompletionBuilder({
    super.key,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    this.shouldRebuildOnConfigChanged = false,
    required this.onLoadingBuilder,
    required this.model,
    this.prompt,
    this.maxTokens,
    this.temperature,
    this.bestOf,
    this.n,
    this.stop,
    this.presencePenalty,
    this.frequencyPenalty,
    this.logprobs,
    this.echo,
    this.logitBias,
    this.suffix,
    this.topP,
    this.user,
  });

  final Widget Function(BuildContext context, OpenAICompletionModel model)
      onSuccessBuilder;
  final Widget Function(BuildContext context, Object error) onErrorBuilder;
  final Widget Function(BuildContext context) onLoadingBuilder;
  final bool shouldRebuildOnConfigChanged;
  final String model;
  final String? prompt;
  final int? maxTokens;
  final double? temperature;
  final int? bestOf;
  final int? n;
  final String? stop;
  final double? presencePenalty;
  final double? frequencyPenalty;
  final int? logprobs;
  final bool? echo;
  final Map<String, double>? logitBias;
  final String? suffix;
  final double? topP;
  final String? user;

  @override
  State<OpenAICompletionBuilder> createState() =>
      _OpenAICompletionBuilderState();
}

class _OpenAICompletionBuilderState extends State<OpenAICompletionBuilder> {
  late Future<OpenAICompletionModel> future;

  @override
  void initState() {
    future = OpenAI.instance.completion.create(
      prompt: widget.prompt,
      maxTokens: widget.maxTokens,
      temperature: widget.temperature,
      model: widget.model,
      bestOf: widget.bestOf,
      n: widget.n,
      stop: widget.stop,
      presencePenalty: widget.presencePenalty,
      frequencyPenalty: widget.frequencyPenalty,
      logprobs: widget.logprobs,
      echo: widget.echo,
      logitBias: widget.logitBias,
      suffix: widget.suffix,
      topP: widget.topP,
      user: widget.user,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAICompletionBuilder oldWidget) {
    if (widget.shouldRebuildOnConfigChanged) {
      setState(() {
        future = OpenAI.instance.completion.create(
          prompt: widget.prompt,
          maxTokens: widget.maxTokens,
          temperature: widget.temperature,
          model: widget.model,
          bestOf: widget.bestOf,
          n: widget.n,
          stop: widget.stop,
          presencePenalty: widget.presencePenalty,
          frequencyPenalty: widget.frequencyPenalty,
          logprobs: widget.logprobs,
          // TODO: fix echo in dart_openai.
          // echo: echo,
          logitBias: widget.logitBias,
          suffix: widget.suffix,
          topP: widget.topP,
          user: widget.user,
        );
      });

      return;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<OpenAICompletionModel>(
      future: future,
      shouldRebuildOnConfigChanged: widget.shouldRebuildOnConfigChanged,
      builder: (
        BuildContext context,
        AsyncSnapshot<OpenAICompletionModel> modelSnapshot,
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
