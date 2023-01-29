import 'package:flutter/material.dart';

class SimpleProvider<T> extends StatefulWidget {
  const SimpleProvider({
    super.key,
    this.create,
    this.onDispose,
    required this.child,
  }) : value = null;

  const SimpleProvider.value({
    super.key,
    this.value,
    required this.child,
  })  : create = null,
        onDispose = null;

  final T? value;

  final T Function()? create;

  final void Function(T)? onDispose;

  final Widget child;

  @override
  State<SimpleProvider<T>> createState() => _SimpleProviderState<T>();

  static T of<T>(BuildContext context, {bool listen = false}) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_ProviderScope<T>>()
        : context.findAncestorWidgetOfExactType<_ProviderScope<T>>();

    return scope!.value;
  }
}

class _SimpleProviderState<T> extends State<SimpleProvider<T>> {
  T? value;

  @override
  Widget build(BuildContext context) {
    return _ProviderScope<T>(
      value: value ??= widget.value ?? widget.create!(),
      child: widget.child,
    );
  }
}

class _ProviderScope<T> extends InheritedWidget {
  const _ProviderScope({
    super.key,
    required this.value,
    required super.child,
  });

  final T value;

  @override
  bool updateShouldNotify(_ProviderScope<T> oldWidget) {
    return oldWidget.value != value;
  }

  @override
  InheritedElement createElement() => _InheritedElement<T>(this);
}

class _InheritedElement<T> extends InheritedElement {
  _InheritedElement(_ProviderScope<T> widget) : super(widget) {
    final value = widget.value;
    if (value is Listenable) value.addListener(_handleUpdate);
  }

  bool _dirty = false;

  @override
  void update(_ProviderScope<T> newWidget) {
    final T oldValue = (widget as _ProviderScope<T>).value;
    final T newValue = newWidget.value;
    if (oldValue != newValue) {
      if (oldValue is Listenable) oldValue.removeListener(_handleUpdate);
      if (newValue is Listenable) newValue.addListener(_handleUpdate);
    }
    super.update(newWidget);
  }

  @override
  Widget build() {
    if (_dirty) notifyClients(widget as _ProviderScope<T>);
    return super.build();
  }

  @override
  void notifyClients(_ProviderScope<T> oldWidget) {
    super.notifyClients(oldWidget);
    _dirty = false;
  }

  @override
  void unmount() {
    final value = (widget as _ProviderScope<T>).value;
    if (value is Listenable) value.removeListener(_handleUpdate);
    super.unmount();
  }

  void _handleUpdate() {
    _dirty = true;
    markNeedsBuild();
  }
}