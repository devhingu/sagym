import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/forgotpassword/forgot_password.dart';
import 'package:gym/ui/auth/screens/signup/sign_up_screen.dart';
import 'package:gym/widgets/auth/bottom_rich_text.dart';
import 'package:gym/widgets/auth/auth_custom_button.dart';
import 'package:gym/widgets/auth/social_media_button.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:gym/widgets/top_logo_title_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TopLogoTitleWidget(),
              heightSizedBox(height: 40.0),
              TextFormFieldContainer(
                label: kEmail,
                obscureText: false,
                inputType: TextInputType.emailAddress, margin:  kAuthPadding,
              ),
              TextFormFieldContainer(
                label: kPassword,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                margin:  kAuthPadding,
              ),
              heightSizedBox(height: 15.0),
              CustomButton(
                title: kSignIn,
                onPress: () {},
              ),
              heightSizedBox(height: 5.0),
              forgotPasswordWidget(),
              const Padding(
                padding: kDividerPadding,
                child: Divider(),
              ),
              const SocialMediaButton(),
              BottomRichText(
                startText: kDoNotHaveAnAccount,
                endText: kSignUp,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
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

  GestureDetector forgotPasswordWidget() => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            ),
          );
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Text(
              kForgotPassword,
              style: kForgotPasswordTextStyle,
            ),
          ),
        ),
      );
}

// Row(children: <Widget>[
// Expanded(
// child: Container(
// margin: const EdgeInsets.only(left: 32.0, right: 10.0),
// child: const Divider(
// color: kGreyColor,
// height: 50,
// )),
// ),
// const Text("OR", style: kTextFormFieldLabelTextStyle,),
// Expanded(
// child: Container(
// margin: const EdgeInsets.only(left: 10.0, right: 32.0),
// child: const Divider(
// color: kGreyDarkColor,
// height: 50,
// )),
// ),
// ]),
