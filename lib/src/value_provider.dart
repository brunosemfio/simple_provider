import 'package:flutter/material.dart';

class ValueProvider<T> extends StatelessWidget {
  const ValueProvider({
    super.key,
    required this.value,
    required this.child,
  });

  final T value;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ValueScope<T>(
      value: value,
      child: child,
    );
  }

  static T of<T>(BuildContext context, {bool listen = false}) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_ValueScope<T>>()
        : context.findAncestorWidgetOfExactType<_ValueScope<T>>();

    return scope!.value;
  }
}

class _ValueScope<T> extends InheritedWidget {
  const _ValueScope({
    super.key,
    required this.value,
    required super.child,
  });

  final T value;

  @override
  bool updateShouldNotify(_ValueScope<T> oldWidget) {
    return oldWidget.value != value;
  }
}
