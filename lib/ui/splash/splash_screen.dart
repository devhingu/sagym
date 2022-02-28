import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';

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
      // if (status == AnimationStatus.completed) {
      //   final kCurrentUser = FirebaseAuth.instance.currentUser;
      //   if (kCurrentUser?.email == null) {
      //     navigatePushReplacementScreen(context, const SignInScreen());
      //   } else {
      //     navigatePushReplacementScreen(context, const HomePage());
      //   }
      // }
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
        child: Image.asset(
          kDumbbellImagePath,
          width: animation.value,
          //height: _animation.value,
        ),
      ),
    );
  }
}
