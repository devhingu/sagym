import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym/constants/constants.dart';

import '../color_constants.dart';

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

Widget customCircularIndicator() => const Center(
      child: Padding(
        padding: kAllSideSmallPadding,
        child: CircularProgressIndicator(
          color: kMainColor,
        ),
      ),
    );

void showMessage(String value) {
  Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: kMainColor,
      textColor: Colors.white,
      fontSize: 16.0
  );
}