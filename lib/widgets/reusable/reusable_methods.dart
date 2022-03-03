import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../service/list_provider.dart';

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

final _fireStore = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;

Future getCurrentData(context) async {
  var snapshot = _fireStore
      .collection("Trainers")
      .doc(user?.email)
      .collection("memberDetails")
      .snapshots();

  snapshot.forEach((element) {
    Provider.of<MemberData>(context, listen: false)
        .updateAmount(element.docs);
    Provider.of<MemberData>(context, listen: false)
        .updateUserStatus(element.docs);
  });
}
