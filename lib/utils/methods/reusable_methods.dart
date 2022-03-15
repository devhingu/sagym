import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants.dart';

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

navigatePushAndRemoveUntil(context, screen) {
  Navigator.pushNamedAndRemoveUntil(context, screen, (route) => false);
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
        padding: kAllSidePadding,
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
      fontSize: 16.0);
}

String? validateEmail(String? email) {
  if (email!.trim().isEmpty) {
    return 'Please enter email!';
  } else if (!emailValid.hasMatch(email)) {
    return 'Please enter valid email!';
  } else {
    return null;
  }
}

String? validatePassword(String? password) {
  if (password!.trim().isEmpty) {
    return 'Please enter password!';
  } else if (password.length < 6) {
    return 'Password should be at least 6 characters!';
  }
  return null;
}

String? validateName(String? userName) {
  if (userName!.trim().isEmpty) {
    return 'Please enter username!';
  } else if (userName.length < 3) {
    return 'Username should be at least 3 characters!';
  }
  return null;
}

String? validateMobile(String? phone) {
  String phoneValid = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(phoneValid);
  if (phone!.isEmpty) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(phone)) {
    return 'Mobile Number should be at least 10 digits';
  }
  return null;
}
