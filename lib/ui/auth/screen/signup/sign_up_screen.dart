import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/service/firebase_auth_service.dart';
import 'package:gym/ui/dashboard/screen/home_page.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screen/login/sign_in_screen.dart';
import 'package:gym/widgets/auth/bottom_rich_text.dart';
import 'package:gym/widgets/auth/social_media_button.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/constants/methods/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:gym/widgets/top_logo_title_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "sign_up_screen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _fireStore = FirebaseFirestore.instance;
  bool isSignup = false;

  @override
  void dispose() {
    super.dispose();
    _userNameFocusNode.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TopLogoTitleWidget(),
                  _userNameTextField(context),
                  _emailTextField(context),
                  _passwordTextField(context),
                  heightSizedBox(height: 15.0),
                  _signUpButton(context),
                  const Padding(
                    padding: kDividerPadding,
                    child: Divider(),
                  ),
                  const SocialMediaButton(),
                  Padding(
                    padding: kAllSideSmallPadding,
                    child: BottomRichText(
                      startText: kAlreadyHaveAnAccount,
                      endText: kSignIn,
                      onPress: () {
                        navigatePushReplacementMethod(context, SignInScreen.id);
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

  _signUpButton(BuildContext context) => isSignup
      ? customCircularIndicator()
      : CustomButton(
          title: kSignUp,
          onPress: () async {
            await _saveDetailsToFirebaseFirestore();
            if (FirebaseAuth.instance.currentUser?.email != null) {
              navigatePushReplacementMethod(context, HomePage.id);
            }
          },
        );

  TextFormFieldContainer _passwordTextField(BuildContext context) =>
      TextFormFieldContainer(
        label: kPassword,
        inputType: TextInputType.visiblePassword,
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(context, _passwordFocusNode);
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

  TextFormFieldContainer _userNameTextField(BuildContext context) =>
      TextFormFieldContainer(
        label: kUsername,
        inputType: TextInputType.text,
        controller: _userNameController,
        focusNode: _userNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(
            context,
            _userNameFocusNode,
            _emailFocusNode,
          );
        },
      );

  _saveDetailsToFirebaseFirestore() async {
    var emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (_userNameController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        emailValid.hasMatch(_emailController.text)) {
      FirebaseService firebaseService = FirebaseService();
      await firebaseService.signUpWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        isSignup = true;
      });

      try {
        await _fireStore.collection("Trainers").doc(_emailController.text).set({
          'userName': _userNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });
        setState(() {
          isSignup = false;
        });
        showMessage("Sign up Successfully!");
        _userNameController.clear();
        _emailController.clear();
        _passwordController.clear();
      } catch (e) {
        setState(() {
          isSignup = false;
        });
        showMessage("Please enter correct details!");
      }
    } else {
      showMessage("Please Enter Details!");
    }
  }
}
