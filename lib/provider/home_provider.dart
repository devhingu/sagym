import 'package:flutter/material.dart';

class MemberData with ChangeNotifier {
  int receivedAmount = 0;
  int dueAmount = 0;
  int activeCount = 0;
  int inActiveCount = 0;
  int totalUser = 0;
  int dueUserCount = 0;
  bool status = false;

  int get receivedAmounts {
    return receivedAmount;
  }

  int get dueAmounts {
    return dueAmount;
  }

  int get activeCounts {
    return activeCount;
  }

  int get inActiveCounts {
    return inActiveCount;
  }

  int get totalUsers {
    return totalUser;
  }

  int get dueUserCounts {
    return dueUserCount;
  }

  void updateAmount(dynamic data, [int value = 0]) {
    receivedAmount = value;
    dueAmount = value;
    for (int i = 0; i < data.length; i++) {
      receivedAmount += int.parse(data[i]["receivedAmount"]);
      dueAmount += int.parse(data[i]["dueAmount"]);
      notifyListeners();
    }
  }

  void updateUserStatus(dynamic data, [int value = 0]) {
    totalUser = data.length;
    activeCount = value;
    inActiveCount = value;
    dueUserCount = value;
    for (int i = 0; i < data.length; i++) {
      if (data[i]["status"] == true) {
        activeCount++;
      } else {
        inActiveCount++;
      }

      if (data[i]["dueAmount"] != "0") {
        dueUserCount++;
      }
    }
    notifyListeners();
  }
}
