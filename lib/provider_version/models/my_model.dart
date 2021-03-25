import 'package:flutter/foundation.dart';

class MyModel with ChangeNotifier {
  int value = 0;

  // Don't return a value, just increment it and call notifyListeners()
  void increment() {
    value += 1;
    notifyListeners();
  }
}
