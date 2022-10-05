import 'package:flutter/material.dart';
import 'package:notifiable/notifiable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifiable Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemNotifiableExample(),
    );
  }
}

class ItemNotifiableExample extends StatelessWidget {
  final _model = TitleAndSubtitle();
  final _titleChangeNotifier = Notifier();
  final _subtitleChangeNotifier = Notifier();

  ItemNotifiableExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Notifiable(
            notifier: _titleChangeNotifier,
            builder: (context) => Text(
              _model.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          TextButton(
            child: Container(
              width: double.infinity,
              height: 30,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "TAP TO CHANGE THE TITLE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onPressed: () {
              _model.title = "This is the new title";
              _titleChangeNotifier.notify();
            },
          ),
          const SizedBox(height: 60),
          Notifiable(
            notifier: _subtitleChangeNotifier,
            builder: (context) => Text(
              _model.subtitle,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          TextButton(
            child: Container(
              width: double.infinity,
              height: 30,
              color: Colors.green,
              child: const Center(
                child: Text(
                  "TAP TO CHANGE THE SUBTITLE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onPressed: () {
              _model.subtitle = "This is the new subtitle";
              _subtitleChangeNotifier.notify();
            },
          )
        ],
      ),
    );
  }
}

class TitleAndSubtitle {
  var title = "Title";
  var subtitle = "Subtitle";
}
