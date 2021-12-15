# Sift
A simple notifiable widget that allows updating specific widgets without
updating the whole widget tree.

## Usage
```
final _notifier = Notifier();

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
```