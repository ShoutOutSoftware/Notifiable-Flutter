// ignore_for_file: unnecessary_null_comparison
library value_notifiable;

import 'package:flutter/widgets.dart';

class TwoItemNotifier<T, V> {
  late T _value1;
  late V _value2;
  final List<VoidCallback> _listeners = [];

  TwoItemNotifier({required T defaultValue1, required V defaultValue2})
      : _value1 = defaultValue1,
        _value2 = defaultValue2;

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notify(T value1, V value2) {
    _value1 = value1;
    _value2 = value2;
    for (var listener in _listeners) {
      listener.call();
    }
  }

  void dispose() {
    _listeners.clear();
  }
}

class TwoItemNotifiable<T, V> extends StatefulWidget {
  final TwoItemNotifier<T, V> notifier;
  final Widget Function(BuildContext context, T value1, V value2) builder;

  const TwoItemNotifiable({
    Key? key,
    required this.notifier,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TwoItemNotifiableState<T, V>();
}

class _TwoItemNotifiableState<T, V> extends State<TwoItemNotifiable<T, V>> {
  late T value1;
  late V value2;
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    value1 = widget.notifier._value1;
    value2 = widget.notifier._value2;
    _addListener();
  }

  @override
  void didUpdateWidget(TwoItemNotifiable<T, V> oldWidget) {
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(listener);
      value1 = widget.notifier._value1;
      value2 = widget.notifier._value2;
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
      value1 = widget.notifier._value1;
      value2 = widget.notifier._value2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value1, value2);
  }
}
