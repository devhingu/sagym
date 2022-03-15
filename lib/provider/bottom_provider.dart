import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigationData with ChangeNotifier {
  late int _selectedIndex = 0;

  int get getSelectedIndex {
    return _selectedIndex;
  }

  void setUpdatedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void getIndex() async {
    final _prefs = await SharedPreferences.getInstance();
    if (_prefs.getBool("isLoggedIn") == false) {
      _selectedIndex = 0;
    }
  }
}
