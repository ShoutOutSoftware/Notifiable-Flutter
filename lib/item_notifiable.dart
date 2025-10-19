// ignore_for_file: unnecessary_null_comparison
library value_notifiable;

import 'package:flutter/widgets.dart';

class ItemNotifier<T> {
  late T _value;
  final List<VoidCallback> _listeners = [];

  ItemNotifier({required T defaultValue}) : _value = defaultValue;

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notify(T value) {
    _value = value;
    for (var listener in _listeners) {
      listener.call();
    }
  }

  void dispose() {
    _listeners.clear();
  }
}

class ItemNotifiable<T> extends StatefulWidget {
  final ItemNotifier<T> notifier;
  final Widget Function(BuildContext context, T value) builder;

  const ItemNotifiable({
    Key? key,
    required this.notifier,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemNotifiableState<T>();
}

class _ItemNotifiableState<T> extends State<ItemNotifiable<T>> {
  late T value;
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    value = widget.notifier._value;
    _addListener();
  }

  @override
  void didUpdateWidget(ItemNotifiable<T> oldWidget) {
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(listener);
      value = widget.notifier._value;
      _addListener();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.notifier.removeListener(listener);
    super.dispose();
  }

  void _addListener() {
    listener = _valueChanged;
    widget.notifier.addListener(listener);
  }

  void _valueChanged() {
    setState(() {
      value = widget.notifier._value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}
