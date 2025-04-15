import 'package:flutter/material.dart';

class SelectedPageProvider extends ChangeNotifier {
  int _selected = 0;

  int getSelected() => _selected;

  void changePage(int i) {
    _selected = i;
    notifyListeners();
  }
}
