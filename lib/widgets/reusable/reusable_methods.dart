import 'package:flutter/material.dart';

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
