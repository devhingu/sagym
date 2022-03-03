import 'package:flutter/foundation.dart';

class Model with ChangeNotifier{
  final String userName;

  Model({required this.userName});

  String get getname{
    return userName;
  }
}