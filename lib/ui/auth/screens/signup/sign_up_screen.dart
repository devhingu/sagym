import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/home_page.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/widgets/auth/bottom_rich_text.dart';
import 'package:gym/widgets/auth_custom_button.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:gym/widgets/top_logo_title_widget.dart';

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
              const TopLogoTitleWidget(),
              heightSizedBox(height: 40.0),
              TextFormFieldContainer(
                label: kUsername,
                obscureText: false,
              ),
              TextFormFieldContainer(
                label: kEmail,
                obscureText: false,
              ),
              TextFormFieldContainer(
                label: kPassword,
                obscureText: true,
              ),
              heightSizedBox(height: 15.0),
              CustomButton(
                title: kSignUp,
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
                padding: EdgeInsets.only(top: 16.0, right: 32.0, left: 32.0),
                child: Divider(),
              ),
              Padding(
                padding: kAuthPadding,
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
                startText: kAlreadyHaveAnAccount,
                endText: kSignIn,
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
}
