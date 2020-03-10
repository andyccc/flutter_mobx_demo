import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier {
  int _count = 0;

  get count => _count;

  void addCount() {
    _count++;
    notifyListeners();
  }
}
