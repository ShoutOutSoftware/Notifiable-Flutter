import 'package:flutter/material.dart';
import 'package:notifiable/item_notifiable.dart';

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
      home: NotifiableExample(),
    );
  }
}

class NotifiableExample extends StatelessWidget {
  final _titleChangeNotifier = ItemNotifier<String>(defaultValue: "Default title");
  final _subTitleChangeNotifier = ItemNotifier<String?>(defaultValue: null);

  NotifiableExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          ItemNotifiable<String>(
            notifier: _titleChangeNotifier,
            builder: (context, title) => Text(
              title,
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
              _titleChangeNotifier.notify("This is the new title");
            },
          ),
          const SizedBox(height: 60),
          ItemNotifiable<String?>(
            notifier: _subTitleChangeNotifier,
            builder: (context, subTitle) => Text(
              subTitle ?? "The subtitle is null",
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
              _subTitleChangeNotifier.notify("This is the new subtitle");
            },
          ),
        ],
      ),
    );
  }
}
