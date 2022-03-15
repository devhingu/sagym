import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../constants/text_style_constants.dart';
import '../../../utils/methods/reusable_methods.dart';
import '../../auth/screen/login/sign_in_screen.dart';
import '../../dashboard/screen/home_page.dart';
import '../../welcome/screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<dynamic> _animation;

  void animationListener() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animation = Tween(begin: 70.0, end: 100.0).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    _controller.forward();

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        final _prefs = await SharedPreferences.getInstance();
        bool _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
        bool _newToApp = _prefs.getBool('newUser') ?? true;

        if (_isLoggedIn) {
          navigatePushReplacementMethod(context, HomePage.id);
        } else {
          if (_newToApp) {
            navigatePushReplacementMethod(context, WelcomeScreen.id);
          } else {
            navigatePushReplacementMethod(context, SignInScreen.id);
          }
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: _animatedImage(),
            ),
            _appTitle(),
          ],
        ),
      ),
    );
  }

  Image _animatedImage() => Image.asset(
        kDumbbellImagePath,
        height: _animation.value,
      );

  Text _appTitle() => Text(
        kTitleSaGym,
        style: kAppTitleTextStyle.copyWith(
          fontSize: 35.0,
          color: kBlackColor,
          fontWeight: FontWeight.bold,
        ),
      );
}
