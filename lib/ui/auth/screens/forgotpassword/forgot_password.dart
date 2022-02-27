import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:gym/widgets/top_logo_title_widget.dart';

import '../../../../widgets/reusable/reusable_methods.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = "forgot_password_screen";

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: kHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TopLogoTitleWidget(),
                  Padding(
                    padding: kAllSideSmallPadding,
                    child: Text(
                      kForgotPassword,
                      style: kForgotPasswordTextStyle,
                    ),
                  ),
                  Text(
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
    );
  }

  CustomButton _submitButton() => CustomButton(
        title: kSubmit,
        onPress: () {
          debugPrint("done");
        },
      );

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
      );
}
