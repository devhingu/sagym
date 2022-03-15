import 'package:flutter/cupertino.dart';

//regex
var emailValid = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

//duration
const kDuration = Duration(milliseconds: 500);

//paddings
const kAllSideSmallPadding = EdgeInsets.all(8.0);
const kAllSideVerySmallPadding = EdgeInsets.all(4.0);
const kAllSidePadding = EdgeInsets.all(16.0);
const kAllSideBigPadding = EdgeInsets.all(20.0);
const kHorizontalPadding = EdgeInsets.symmetric(horizontal: 32.0);
const kSmallHorizontalPadding = EdgeInsets.symmetric(vertical: 4.0);
const kTopSmallPadding = EdgeInsets.only(top: 16.0);
const kTopPadding = EdgeInsets.only(top: 32.0);
const kTBottomPadding = EdgeInsets.only(bottom: 16.0);
const kDividerPadding = EdgeInsets.only(top: 16.0, bottom: 8.0);
const kThreeSidePadding = EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0);

//bottom nav items
const kBottomNavItems = [
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.home),
    label: "Home",
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.person_2),
    label: "Members",
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.location),
    label: "Location",
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.profile_circled),
    label: "Account",
  ),
];

//batch list
final batchList = ["Morning", "Evening"];

//membership plan list
final memberShipPlanList = ["3 Months", "6 Months", "9 Months", "1 Year"];

//payment type list
final paymentTypeList = ["Cash", "Paytm", "G Pay", "Phonepe"];

//payment status
final paymentStatusList = ["Success", "Pending"];

//gym accessories type list
final accessoriesTypeList = [
  "Dumbbells",
  "Punching bag",
  "Exercise ball",
  "A pull-up bar",
  "An ab wheel"
];

