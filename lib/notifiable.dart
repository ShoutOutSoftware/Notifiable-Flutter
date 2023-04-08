// ignore_for_file: unnecessary_null_comparison
library notifiable;

import 'package:flutter/widgets.dart';

class Notifier {
  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notify() {
    for (var listener in _listeners) {
      listener.call();
    }
  }
}

class Notifiable extends StatefulWidget {
  final Notifier notifier;
  final Widget Function(BuildContext context) builder;

  const Notifiable({
    Key? key,
    required this.notifier,
    required this.builder,
  })  : assert(notifier != null),
        assert(builder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _NotifiableState();
}

class _NotifiableState extends State<Notifiable> {
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    _addListener();
  }

  @override
  void didUpdateWidget(Notifiable oldWidget) {
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(listener);
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
