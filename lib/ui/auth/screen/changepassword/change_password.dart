import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../constants/text_style_constants.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/text_form_field_container.dart';
import '../../../../widgets/top_logo_title_widget.dart';


class ChangePasswordScreen extends StatefulWidget {
  static const String id = "change_password_screen";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  bool isSubmit = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kChangePassword),
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
                        kChangePassword,
                        style: kForgotPasswordTextStyle,
                      ),
                    ),
                    _passwordTextField(context),
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

  TextFormFieldContainer _passwordTextField(BuildContext context) =>
      TextFormFieldContainer(
        label: kChangePassword,
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

  Widget _submitButton() => isSubmit
      ? customCircularIndicator()
      : CustomButton(
          title: kSubmit,
          onPress: _changePassword,
        );

  _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isSubmit = true;
        });
        final user = FirebaseAuth.instance.currentUser;
        await user?.updatePassword(_passwordController.text.toString());
        setState(() {
          isSubmit = false;
        });
        Navigator.pop(context);
        showMessage("Change password successfully!");
      } catch (e) {
        setState(() {
          isSubmit = false;
        });
        showMessage("Change password failed!");
      }
    }
  }
}
