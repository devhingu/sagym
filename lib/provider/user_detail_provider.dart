import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String name = "";
  String email = "";
  String image = "";

  void updateProfile(snapshot) {
    name = snapshot.get("userName");
    email = snapshot.get("email");
    image = snapshot.get("profileImage");
    notifyListeners();
  }

  void updateData() {
    name = "";
    email = "";
    image = "";
    notifyListeners();
  }

  String get userName => name;

  String get userEmail => email;

  String get profileImage => image;
}
