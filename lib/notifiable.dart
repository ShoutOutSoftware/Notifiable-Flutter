// ignore_for_file: unnecessary_null_comparison

library notifiable;

import 'package:flutter/widgets.dart';

class Notifier {
  VoidCallback? _listener;

  void setListener(VoidCallback listener) {
    _listener = listener;
  }

  void removeListener() {
    _listener = null;
  }

  void notify() {
    _listener?.call();
  }
}

class Notifiable extends StatefulWidget {
  final Notifier notifier;
  final Function(BuildContext context) builder;

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

class _NotifiableState<T> extends State<Notifiable> {
  @override
  void initState() {
    super.initState();
    widget.notifier.setListener(_updateState);
  }

  @override
  void didUpdateWidget(Notifiable oldWidget) {
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener();
      widget.notifier.setListener(_updateState);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.notifier.removeListener();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
