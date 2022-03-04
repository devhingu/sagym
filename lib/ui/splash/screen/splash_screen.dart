import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/dashboard/screen/home_page.dart';
import 'package:gym/constants/methods/reusable_methods.dart';

import '../../../constants/color_constants.dart';
import '../../welcome/screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void animate() {
    Future.delayed(const Duration(seconds: 6), () {
      final _currentUser = FirebaseAuth.instance.currentUser;

      if (_currentUser?.email == null) {
        navigatePushReplacementMethod(context, WelcomeScreen.id);
      } else {
        navigatePushReplacementMethod(context, HomePage.id);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _animatedImage(),
            _appTitle(),
          ],
        ),
      ),
    );
  }

  Text _appTitle() => Text(
        kTitleSaGym,
        style: kAppTitleTextStyle.copyWith(
          fontSize: 35.0,
          color: kBlackColor,
        ),
      );

  Image _animatedImage() => Image.asset(
        "assets/icon.gif",
        height: 85.0,
      );
}
