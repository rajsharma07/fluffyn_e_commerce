import 'package:flutter/foundation.dart';

class AuthPageProvider extends ChangeNotifier {
  int _page = 0;
  int getPage() => _page;

  void change(int i) {
    _page = i;
    notifyListeners();
  }
}
