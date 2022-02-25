import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';

//strings
String kTotalMembers = "Total Members ";

//icons
const kEllipsisIcon = CupertinoIcons.ellipsis_vertical;

//image paths
const kAvatarImagePath = "assets/avatar.png";

//text styles
const kAppBarTextStyle = TextStyle(
  color: kLightWhiteColor,
  fontSize: 18.0,
);

const kTitleTextStyle = TextStyle(
  color: kWhiteColor,
  fontSize: 25.0,
);

const kMemberCountTextStyle = TextStyle(
  color: kWhiteColor,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const kDateTextStyle = TextStyle(
  color: kLightWhiteColor,
  fontSize: 14.0,
);

const kCardTitleTextStyle = TextStyle(
  color: kMainColor,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
);

//box decoration
BoxDecoration kCardBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5.0),
  boxShadow: [
    BoxShadow(
      offset: const Offset(0, 5),
      color: kBlackColor.withOpacity(0.2),
      blurRadius: 8.0,
    )
  ],
);
