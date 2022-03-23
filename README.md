# Notifiable
A simple notifiable widget that allows updating specific widgets without
updating the whole widget tree.

## Notifiable Usage
```
final _model = TitleAndSubtitle();
final _titleChangeNotifier = Notifier();

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
)

class TitleAndSubtitle {
  var title = "Title";
  var subtitle = "Subtitle";
}
```

## Item Notifiable Usage
```
final _titleChangeNotifier = ItemNotifier<String>(defaultValue: "Default title");
final _subTitleChangeNotifier = ItemNotifier<String?>(defaultValue: null);

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
```