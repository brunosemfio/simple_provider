import 'package:flutter/material.dart';

class NotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const NotifierProvider({
    super.key,
    required this.create,
    required this.child,
    this.onDispose,
  });

  final T Function() create;

  final Widget child;

  final void Function(T)? onDispose;

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
  T? _notifier;

  @override
  Widget build(BuildContext context) {
    return _NotifierScope<T>(
      notifier: _notifier ??= widget.create(),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (_notifier != null) widget.onDispose?.call(_notifier!);
    super.dispose();
  }
}

class _NotifierScope<T extends ChangeNotifier> extends InheritedNotifier<T> {
  const _NotifierScope({
    required super.notifier,
    required super.child,
  });
}
