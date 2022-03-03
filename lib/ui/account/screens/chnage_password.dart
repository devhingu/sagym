import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/service/firebase_service.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:gym/widgets/top_logo_title_widget.dart';

import '../../../../widgets/reusable/reusable_methods.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String id = "change_password_screen";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: kHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TopLogoTitleWidget(),
                  const Padding(
                    padding: kAllSideSmallPadding,
                    child: Text(
                      "Change Password",
                      style: kForgotPasswordTextStyle,
                    ),
                  ),
                  _emailTextField(context),
                  _submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomButton _submitButton() => CustomButton(
        title: kSubmit,
        onPress: () async {
          final user = FirebaseAuth.instance.currentUser;
          await user?.updatePassword(_passwordController.text.toString());
          FirebaseService firebaseService = FirebaseService();
          await firebaseService.signOutFromFirebase();
          navigatePushReplacementMethod(context, SignInScreen.id);
        },
      );

  TextFormFieldContainer _emailTextField(BuildContext context) =>
      TextFormFieldContainer(
        label: "Change Password",
        inputType: TextInputType.emailAddress,
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(
            context,
            _passwordFocusNode,
          );
        },
      );
}
