import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/ui/welcome/screens/welcome_screen.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import '../../constants/color_constants.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double>  animation, _animation;
  late AnimationController controller;

  void animationListener() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = Tween(begin: 15.0, end: 35.0).animate(controller);
    _animation = CurvedAnimation(parent: animation, curve: Curves.linear);

    _animation.addListener(() {
      setState(() {});
    });
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final kCurrentUser = FirebaseAuth.instance.currentUser;
        if (kCurrentUser?.email == null) {
          navigatePushReplacementMethod(context,  WelcomeScreen.id);
        } else {
          navigatePushReplacementMethod(context, HomePage.id);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    animationListener();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              kDumbbellImagePath,
              height: 80.0,
              color: kMainColor,
            ),
            Text(kTitleSaGym, style: kAppTitleTextStyle.copyWith(fontSize: animation.value),),
          ],
        ),
      ),
    );
  }
}
