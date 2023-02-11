import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatefulWidget {
  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
    this.initialData,
    this.shouldRebuildOnStateChange = false,
  });

  final Future<T> future;
  final AsyncWidgetBuilder<T> builder;
  final T? initialData;
  final bool shouldRebuildOnStateChange;

  @override
  State<CustomFutureBuilder> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  late Future<T> future;
  @override
  void initState() {
    if (widget.shouldRebuildOnStateChange) {
      future = widget.future;
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomFutureBuilder<T> oldWidget) {
    if (widget.shouldRebuildOnStateChange) {
      future = widget.future;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.shouldRebuildOnStateChange ? future : widget.future,
      builder: widget.builder,
      initialData: widget.initialData,
    );
  }
}