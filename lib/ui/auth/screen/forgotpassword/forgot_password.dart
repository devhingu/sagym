import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../constants/text_style_constants.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/text_form_field_container.dart';
import '../../../../widgets/top_logo_title_widget.dart';
import '../login/sign_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = "forgot_password_screen";

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool isSubmit = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kForgotPassword),
      ),
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
                    const Padding(
                      padding: kAllSideSmallPadding,
                      child: Text(
                        kForgotPassword,
                        style: kForgotPasswordTextStyle,
                      ),
                    ),
                    const Text(
                      kSendEmailForForgotPassword,
                    ),
                    _emailTextField(context),
                    _submitButton(),
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
          onSubmittedUnFocusMethod(
            context,
            _emailFocusNode,
          );
        },
        validator: validateEmail,
      );

  Widget _submitButton() => isSubmit
      ? customCircularIndicator()
      : CustomButton(title: kSubmit, onPress: _forgotPassword);

  _forgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmit = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        setState(() {
          isSubmit = false;
        });
        navigatePushReplacementMethod(context, SignInScreen.id);
        showMessage("Email sent on your mail id!");
      } catch (e) {
        setState(() {
          isSubmit = false;
        });
        showMessage("Email sent failed!");
      }
    }
  }
}
