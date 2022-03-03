import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

//strings
const String kUserProfile = "User Profile";
const String kChangePassword = "Change Password";
const String kLogout = "Logout";
const String kGetHelp = "Get Help";
const String kGiveUsFeedback = "Give Us Feedback";
const String kGymExpenses = "Gym Expenses";
const String kAddedBy = "Added By ";

//icons
const kPasswordIcon =Icons.password;
const kLogoutIcon =Icons.logout;
const kHelpIcon =Icons.help_outline;
const kFeedbackIcon =Icons.messenger_outline;
const kPriceIcon =Icons.price_change_outlined;

//box decorations
BoxDecoration kUserProfileBoxDecoration = BoxDecoration(
  color: kWhiteColor,
  boxShadow: [
    BoxShadow(
      color: kMainColor.withOpacity(0.2),
      offset: const Offset(0, 5),
      blurRadius: 10.0,
    ),
  ],
);

//text styles

const kUserEmailTextStyle = TextStyle(
  color: kGreyColor,
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const kUserNameTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
);
