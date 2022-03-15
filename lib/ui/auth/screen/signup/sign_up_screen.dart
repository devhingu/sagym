import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/param_constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../service/firebase_auth_service.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../utils/models/user_model.dart';
import '../../../../widgets/auth/bottom_rich_text.dart';
import '../../../../widgets/auth/social_media_button.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/text_form_field_container.dart';
import '../../../../widgets/top_logo_title_widget.dart';
import '../../../dashboard/screen/home_page.dart';
import '../login/sign_in_screen.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userNameFocusNode.dispose();
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
                          navigatePushReplacementMethod(
                              context, SignInScreen.id);
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
        validator: validateName,
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
        validator: validateEmail,
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
        validator: validatePassword,
      );

  _signUpButton(BuildContext context) => isSignup
      ? customCircularIndicator()
      : CustomButton(
          title: kSignUp,
          onPress: () async {
            await _saveDetailsToFirebaseFirestore();
            final _prefs = await SharedPreferences.getInstance();
            _prefs.setBool('isLoggedIn', true);
            if (FirebaseAuth.instance.currentUser?.email != null) {
              navigatePushReplacementMethod(context, HomePage.id);
            }
          },
        );

  _saveDetailsToFirebaseFirestore() async {
    if (_formKey.currentState!.validate()) {
      FirebaseService firebaseService = FirebaseService();
      await firebaseService.signUpWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        isSignup = true;
      });

      UserModel userModel = UserModel(
        userName: _userNameController.text,
        email: _emailController.text,
        profileImage: kAvatarImagePath,
      );

      try {
        await _fireStore.collection("Trainers").doc(_emailController.text).set({
          paramUserName: userModel.userName,
          paramEmail: userModel.email,
          paramProfileImage: userModel.profileImage
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
        showMessage("Sign up failed!");
      }
    }
  }
}
