import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';

class OpenAIStreamedCompletionBuilder extends StatefulWidget {
  const OpenAIStreamedCompletionBuilder({
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

  final Widget Function(BuildContext context, OpenAIStreamCompletionModel model)
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
  State<OpenAIStreamedCompletionBuilder> createState() =>
      _OpenAIStreamedCompletionBuilderState();
}

class _OpenAIStreamedCompletionBuilderState
    extends State<OpenAIStreamedCompletionBuilder> {
  late Stream<OpenAIStreamCompletionModel> stream;

  @override
  void initState() {
    stream = OpenAI.instance.completion.createStream(
      prompt: widget.prompt,
      model: widget.model,
      maxTokens: widget.maxTokens,
      temperature: widget.temperature,
      bestOf: widget.bestOf,
      n: widget.n,
      stop: widget.stop,
      presencePenalty: widget.presencePenalty,
      frequencyPenalty: widget.frequencyPenalty,
      logprobs: widget.logprobs,
      // TODO: fix echo in dart_openai.
      // echo: widget.echo,
      logitBias: widget.logitBias,
      suffix: widget.suffix,
      topP: widget.topP,
      user: widget.user,
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenAIStreamedCompletionBuilder oldWidget) {
    if (oldWidget.prompt != widget.prompt ||
        oldWidget.model != widget.model ||
        oldWidget.maxTokens != widget.maxTokens ||
        oldWidget.temperature != widget.temperature ||
        oldWidget.bestOf != widget.bestOf ||
        oldWidget.n != widget.n ||
        oldWidget.stop != widget.stop ||
        oldWidget.presencePenalty != widget.presencePenalty ||
        oldWidget.frequencyPenalty != widget.frequencyPenalty ||
        oldWidget.logprobs != widget.logprobs ||
        oldWidget.echo != widget.echo ||
        oldWidget.logitBias != widget.logitBias ||
        oldWidget.suffix != widget.suffix ||
        oldWidget.topP != widget.topP ||
        oldWidget.user != widget.user) {
      if (widget.shouldRebuildOnConfigChanged) {
        setState(() {
          stream = OpenAI.instance.completion.createStream(
            prompt: widget.prompt,
            model: widget.model,
            maxTokens: widget.maxTokens,
            temperature: widget.temperature,
            bestOf: widget.bestOf,
            n: widget.n,
            stop: widget.stop,
            presencePenalty: widget.presencePenalty,
            frequencyPenalty: widget.frequencyPenalty,
            logprobs: widget.logprobs,
            // TODO: fix echo in dart_openai.
            // echo: widget.echo,
            logitBias: widget.logitBias,
            suffix: widget.suffix,
            topP: widget.topP,
            user: widget.user,
          );
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OpenAIStreamCompletionModel>(
      stream: stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<OpenAIStreamCompletionModel> snapshot,
      ) {
        if (snapshot.hasError) {
          return widget.onErrorBuilder(context, snapshot.error!);
        } else if (snapshot.connectionState == ConnectionState.active) {
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
