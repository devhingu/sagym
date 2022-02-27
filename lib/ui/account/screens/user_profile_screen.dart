import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/service/firebase_service.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = FirebaseService();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/avatar.png"),
                    fit: BoxFit.contain),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                color: kMainColor),
          ),
          heightSizedBox(height: 30.0),
          TextButton(
            onPressed: () async {
              await firebaseService.signOutFromGoogle();
              navigatePushReplacementMethod(context, SignInScreen.id);
            },
            child: Text("Auth Logout"),
          ),
          TextButton(
            onPressed: () async {
              await firebaseService.signOutFromGoogle();
              navigatePushReplacementMethod(context, SignInScreen.id);
            },
            child: Text("Google Logout"),
          ),
          TextButton(
            onPressed: () async {
              await firebaseService.signOutFromFacebook();
              navigatePushReplacementMethod(context, SignInScreen.id);
            },
            child: Text("FB Logout"),
          ),
        ],
      ),
    );
  }
}
