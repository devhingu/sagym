import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/home_page.dart';
import 'package:gym/ui/auth/constants.dart';
import 'package:gym/ui/auth/login/sign_in_screen.dart';
import 'package:gym/widgets/auth/bottom_rich_text.dart';
import 'package:gym/widgets/auth_custom_button.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/text_form_field_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              topLogoText(),
              heightSizedBox(height: 40.0),
              const TextFormFieldContainer(
                label: "Username",
                obscureText: false,
              ),
              const TextFormFieldContainer(
                label: "Email",
                obscureText: false,
              ),
              const TextFormFieldContainer(
                label: "Password",
                obscureText: true,
              ),
              heightSizedBox(height: 15.0),
              CustomButton(
                title: "Sign Up",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 16.0, right: 32.0, left: 32.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: AuthCustomButton(
                        title: kGoogle,
                        onPress: () {},
                        imagePath: kGoogleImagePath,
                      ),
                    ),
                    widthSizedBox(width: 20.0),
                    Expanded(
                      flex: 1,
                      child: AuthCustomButton(
                        title: kFacebook,
                        onPress: () {},
                        imagePath: kFacebookImagePath,
                      ),
                    ),
                  ],
                ),
              ),
              BottomRichText(
                startText: "Already have an account? ",
                endText: "Sign in",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox widthSizedBox({required double width}) {
    return SizedBox(
      width: width,
    );
  }

  SizedBox heightSizedBox({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Column topLogoText() {
    return Column(
      children: [
        Image.asset(
          "assets/dumbbell.png",
          height: 60.0,
          color: kMainColor,
        ),
        const Text(
          "Body Fit Gym",
          style: kAppTitleTextStyle,
        ),
      ],
    );
  }
}
