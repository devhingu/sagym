import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/signup/sign_up_screen.dart';
import 'package:gym/widgets/auth/bottom_rich_text.dart';
import 'package:gym/widgets/auth_custom_button.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:gym/widgets/top_logo_title_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TopLogoTitleWidget(),
            heightSizedBox(height: 40.0),
            Text("Forgot Password", style: kAppTitleTextStyle,),
            Padding(
              padding: kAuthPadding,
              child: Text("We're sending you link for generate new password on Email"),
            ),
            TextFormFieldContainer(
              label: kEmail,
              obscureText: false,
            ),
            CustomButton(
              title: kSubmit,
              onPress: () {
                debugPrint("done");
              },
            ),
          ],
        ),
      ),
    );
  }
}
