import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/home_page.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/ui/dashboard/screens/home_screen.dart';
import 'package:gym/widgets/auth/bottom_rich_text.dart';
import 'package:gym/widgets/auth/auth_custom_button.dart';
import 'package:gym/widgets/auth/social_media_button.dart';
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
              heightSizedBox(height: 25.0),
              TextFormFieldContainer(
                label: kUsername,
                obscureText: false,
                inputType: TextInputType.text,
                margin:  kAuthPadding,
              ),
              TextFormFieldContainer(
                label: kEmail,
                obscureText: false,
                inputType: TextInputType.emailAddress,
                margin:  kAuthPadding,
              ),
              TextFormFieldContainer(
                label: kPassword,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                margin:  kAuthPadding,
              ),
              heightSizedBox(height: 15.0),
              CustomButton(
                title: kSignUp,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
              ),
              const Padding(
                padding: kDividerPadding,
                child: Divider(),
              ),
              const SocialMediaButton(),
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
