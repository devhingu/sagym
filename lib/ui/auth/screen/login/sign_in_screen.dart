import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../constants/text_style_constants.dart';
import '../../../../provider/user_detail_provider.dart';
import '../../../../service/firebase_auth_service.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../widgets/auth/bottom_rich_text.dart';
import '../../../../widgets/auth/social_media_button.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/text_form_field_container.dart';
import '../../../../widgets/top_logo_title_widget.dart';
import '../../../dashboard/screen/home_page.dart';
import '../forgotpassword/forgot_password.dart';
import '../signup/sign_up_screen.dart';

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
  final _fireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  bool isSignIn = false;
  final _formKey = GlobalKey<FormState>();

  Future getCurrentUser() async {
    final snapshots =
    await _fireStore.collection("Trainers").doc(user!.email).get();

    Provider.of<UserData>(context, listen: false).updateProfile(snapshots);
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: kHorizontalPadding,
              child: Form(
                key: _formKey,
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
                          navigatePushReplacementMethod(context, SignUpScreen.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
        validator: validateEmail,
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
        validator: validatePassword,
      );

  _signInButton(BuildContext context) => isSignIn
      ? customCircularIndicator()
      : CustomButton(
          title: kSignIn,
          onPress: () async {
            await _signInWithEmailPassword();
            final _prefs = await SharedPreferences.getInstance();
            _prefs.setBool('isLoggedIn', true);
            if (FirebaseAuth.instance.currentUser?.email != null) {
              navigatePushReplacementMethod(context, HomePage.id);
            }
          },
        );

  GestureDetector _forgotPasswordWidget() => GestureDetector(
        onTap: () {
          navigatePushNamedMethod(context, ForgotPasswordScreen.id);
        },
        child: const Align(
          alignment: Alignment.topRight,
          child: Text(
            kForgotPassword,
            style: kForgotPasswordTextStyle,
          ),
        ),
      );

  _signInWithEmailPassword() async {
    FirebaseService firebaseService = FirebaseService();

    if (_formKey.currentState!.validate()) {
      setState(() {
        isSignIn = true;
      });
      try {
        await firebaseService.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        showMessage("Login Successfully!");
        setState(() {
          isSignIn = false;
        });
        getCurrentUser();
        _emailController.clear();
        _passwordController.clear();
      } catch (e) {
        setState(() {
          isSignIn = false;
        });
        showMessage("Login failed!");
      }
    }
  }
}
