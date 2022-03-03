import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

class SplashScreen extends StatefulWidget {
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
    animation = Tween(begin: 60.0, end: 160.0).animate(controller);
    _animation = CurvedAnimation(parent: animation, curve: Curves.bounceIn);

    _animation.addListener(() {
      setState(() {});
    });
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final kCurrentUser = FirebaseAuth.instance.currentUser;
        if (kCurrentUser?.email == null) {
          navigatePushReplacementMethod(context,  SignInScreen.id);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            kDumbbellImagePath,
            width: animation.value,
          ),
          Text(kTitleSaGym),
        ],
      ),
    );
  }
}
