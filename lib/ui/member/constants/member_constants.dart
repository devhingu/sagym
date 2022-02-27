import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';

//strings
const String kMemberEntries = "Member Entries";
const String kTrainer = "Trainer";
const String kPlan = "Plan";

//icons
const kActiveIcon = Icons.album_outlined;
const kEmailIcon = CupertinoIcons.mail;
const kPhoneIcon = CupertinoIcons.phone;
const kDobIcon = CupertinoIcons.calendar;
const kAddressIcon = CupertinoIcons.location_circle;
const kHeightIcon = CupertinoIcons.resize_v;
const kWeightIcon = CupertinoIcons.person;

//text styles
const kNameTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kNameFirstTextStyle = TextStyle(color: kWhiteColor, fontSize: 50.0);

const kListTileTextStyle = TextStyle(color: kWhiteColor);

//decorations
BoxDecoration kMemberShipCardBoxDecoration = kCardBoxDecoration.copyWith(
  color: kBlackColor,
  boxShadow: [
    BoxShadow(
      offset: const Offset(0, 5),
      color: kBlackColor.withOpacity(0.5),
      blurRadius: 8.0,
    )
  ],
);
