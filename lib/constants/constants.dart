import 'package:flutter/material.dart';
import 'color_constants.dart';

const kAuthPadding = EdgeInsets.symmetric(
  vertical: 16.0,
  horizontal: 32.0,
);

const kCustomButtonMargin = EdgeInsets.symmetric(
  horizontal: 32.0,
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
  color: kGreyDarkColor,
);

const kTextFormFieldTextStyle = TextStyle(
  fontSize: 16.0,
  color: kBlackColor,
  fontWeight: FontWeight.bold,
);
