import 'package:flutter/material.dart';
import 'package:notifiable/two_item_notifiable.dart';

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
  final _titleAndSubtitleChangeNotifier = TwoItemNotifier<String, String?>(
    defaultValue1: "Default title",
    defaultValue2: null,
  );

  NotifiableExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          TwoItemNotifiable<String, String?>(
            notifier: _titleAndSubtitleChangeNotifier,
            builder: (context, title, subtitle) => Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle ?? "The subtitle is null",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
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
              _titleAndSubtitleChangeNotifier.notify("This is the new title", "This is the new subtitle");
            },
          ),
        ],
      ),
    );
  }
}
