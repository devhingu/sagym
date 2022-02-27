import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/service/firebase_service.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/forgotpassword/forgot_password.dart';
import 'package:gym/ui/auth/screens/signup/sign_up_screen.dart';
import 'package:gym/widgets/auth/bottom_rich_text.dart';
import 'package:gym/widgets/auth/social_media_button.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:gym/widgets/top_logo_title_widget.dart';

import '../../../dashboard/screens/home_page.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "sign_in_screen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: kHorizontalPadding,
            child: SizedBox(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TopLogoTitleWidget(),
                  _emailTextField(context),
                  _passwordTextField(context),
                  heightSizedBox(height: 15.0),
                  _signInButton(context),
                  heightSizedBox(height: 5.0),
                  _forgotPasswordWidget(),
                  const Padding(
                    padding: kDividerPadding,
                    child: Divider(),
                  ),
                  const SocialMediaButton(),
                  Padding(
                    padding: kAllSideSmallPadding,
                    child: BottomRichText(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signInButton(BuildContext context) => CustomButton(
        title: kSignIn,
        onPress: () async {
          await signInWithEmail();
          navigatePushReplacementMethod(context, HomePage.id);
        },
      );

  TextFormFieldContainer _passwordTextField(BuildContext context) =>
      TextFormFieldContainer(
        label: kPassword,
        inputType: TextInputType.visiblePassword,
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(
            context,
            _passwordFocusNode,
          );
        },
      );

  TextFormFieldContainer _emailTextField(BuildContext context) =>
      TextFormFieldContainer(
        label: kEmail,
        inputType: TextInputType.emailAddress,
        controller: _emailController,
        focusNode: _emailFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(
            context,
            _emailFocusNode,
            _passwordFocusNode,
          );
        },
      );

  GestureDetector _forgotPasswordWidget() => GestureDetector(
        onTap: () {
          navigatePushNamedMethod(context, ForgotPasswordScreen.id);
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            kForgotPassword,
            style: kForgotPasswordTextStyle,
          ),
        ),
      );

  signInWithEmail() async {
    var emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (_passwordController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        emailValid.hasMatch(_emailController.text)) {
      FirebaseService firebaseService = FirebaseService();
      await firebaseService.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {
      debugPrint("failed");
    }
    _emailController.clear();
    _passwordController.clear();
  }
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
