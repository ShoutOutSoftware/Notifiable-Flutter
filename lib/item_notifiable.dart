// ignore_for_file: unnecessary_null_comparison
library value_notifiable;

import 'package:flutter/widgets.dart';

class ItemNotifier<T> {
  late T _value;
  VoidCallback? _listener;

  ItemNotifier({required T defaultValue}) : _value = defaultValue;

  void setListener(VoidCallback listener) {
    _listener = listener;
  }

  void removeListener() {
    _listener = null;
  }

  void notify(T value) {
    _value = value;
    _listener?.call();
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

  @override
  void initState() {
    super.initState();
    value = widget.notifier._value;
    widget.notifier.setListener(_valueChanged);
  }

  @override
  void didUpdateWidget(ItemNotifiable<T> oldWidget) {
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener();
      value = widget.notifier._value;
      widget.notifier.setListener(_valueChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.notifier.removeListener();
    super.dispose();
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
