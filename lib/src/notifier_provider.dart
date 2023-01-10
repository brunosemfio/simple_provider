import 'package:flutter/material.dart';

class NotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const NotifierProvider({
    super.key,
    required this.value,
    required this.child,
    this.autoDispose = false,
  });

  final T value;

  final Widget child;

  final bool autoDispose;

  @override
  State<NotifierProvider<T>> createState() => _NotifierProviderState<T>();

  static T of<T extends ChangeNotifier>(
    BuildContext context, {
    bool listen = false,
  }) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_NotifierScope<T>>()
        : context.findAncestorWidgetOfExactType<_NotifierScope<T>>();

    return scope!.notifier!;
  }
}

class _NotifierProviderState<T extends ChangeNotifier>
    extends State<NotifierProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _NotifierScope<T>(
      notifier: widget.value,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (widget.autoDispose) widget.value.dispose();
    super.dispose();
  }
}

class _NotifierScope<T extends ChangeNotifier> extends InheritedNotifier<T> {
  const _NotifierScope({
    required super.notifier,
    required super.child,
  });
}
