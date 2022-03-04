import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../provider/home_provider.dart';

SizedBox widthSizedBox({required double width}) => SizedBox(
      width: width,
    );

SizedBox heightSizedBox({required double height}) => SizedBox(
      height: height,
    );

navigatePushNamedMethod(context, screen) {
  Navigator.pushNamed(context, screen);
}

navigatePopAndPushNamedMethod(context, screen) {
  Navigator.popAndPushNamed(context, screen);
}

navigatePushReplacementMethod(context, screen) {
  Navigator.pushReplacementNamed(context, screen);
}

onSubmittedFocusMethod(context, currentFocusNode, nextFocusNode) {
  currentFocusNode.unfocus();
  FocusScope.of(context).requestFocus(nextFocusNode);
}

onSubmittedUnFocusMethod(context, currentFocusNode) {
  currentFocusNode.unfocus();
}

OutlineInputBorder textFormFieldInputBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(color: kGreyColor),
  );
}

SnackBar showSnackBar({required String content}) {
  return SnackBar(
    content: Text(content),
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
  );
}
