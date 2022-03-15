import 'package:flutter/material.dart';
import 'color_constants.dart';

//home
BoxDecoration kCustomButtonBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  color: kMainColor,
);

//user profile
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

//dashboard
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

//member
BoxDecoration kMemberDetailBoxDecoration = BoxDecoration(
  borderRadius: const BorderRadius.only(
    topRight: Radius.circular(25.0),
    topLeft: Radius.circular(25.0),
  ),
  boxShadow: [
    BoxShadow(
      color: kWhiteColor.withOpacity(0.2),
      offset: const Offset(0, -6),
      blurRadius: 8.0,
    ),
  ],
  color: Colors.white,
);
