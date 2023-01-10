import 'package:flutter/material.dart';

class ValueProvider<T> extends InheritedWidget {
  const ValueProvider({
    super.key,
    required this.value,
    required super.child,
  });

  final T value;

  static T of<T>(BuildContext context, {bool listen = false}) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<ValueProvider<T>>()
        : context.findAncestorWidgetOfExactType<ValueProvider<T>>();

    return scope!.value;
  }

  @override
  bool updateShouldNotify(ValueProvider<T> oldWidget) {
    return oldWidget.value != value;
  }
}
