import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Management',
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: kMainColor,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: const SignInScreen(),
    );
  }
}
