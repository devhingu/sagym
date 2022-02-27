import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';

const kAppTitleTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

const kTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

const kAuthButtonTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 16.0,
);

const kCustomButtonTextStyle = TextStyle(
  color: kWhiteColor,
  fontSize: 18.0,
);

BoxDecoration kCustomButtonBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  color: kMainColor,
);

const kTextFormFieldLabelTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
  color: kDarkGreyColor,
);

const kLabelTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kDarkGreyColor,
  letterSpacing: 1.2
);

const kTextFormFieldTextStyle = TextStyle(
  fontSize: 16.0,
  color: kBlackColor,
  fontWeight: FontWeight.bold,
);

//paddings
const kAllSideSmallPadding = EdgeInsets.all(8.0);
const kAllSidePadding = EdgeInsets.all(16.0);
const kAllSideBigPadding = EdgeInsets.all(20.0);
const kHorizontalPadding = EdgeInsets.symmetric(horizontal: 32.0);
const kTopSmallPadding = EdgeInsets.only(top: 16.0);
const kTopPadding = EdgeInsets.only(top: 32.0);
const kDividerPadding = EdgeInsets.only(top: 16.0, bottom: 8.0);

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