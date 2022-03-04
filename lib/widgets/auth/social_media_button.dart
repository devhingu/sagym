import 'package:flutter/cupertino.dart';
import 'package:gym/service/firebase_auth_service.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/constants/methods/reusable_methods.dart';
import 'auth_custom_button.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _googleButton(context),
        widthSizedBox(width: 20.0),
        _facebookButton(context),
      ],
    );
  }

  Expanded _facebookButton(BuildContext context) => Expanded(
        flex: 1,
        child: AuthCustomButton(
          title: kFacebook,
          onPress: () async {
            FirebaseService firebaseService = FirebaseService();
            await firebaseService.signInWithFacebook();
            navigatePushReplacementMethod(context, HomePage.id);
          },
          imagePath: kFacebookImagePath,
        ),
      );

  Expanded _googleButton(BuildContext context) => Expanded(
        flex: 1,
        child: AuthCustomButton(
          title: kGoogle,
          onPress: () async {
            FirebaseService firebaseService = FirebaseService();
            await firebaseService.signInWithGoogle();
            navigatePushReplacementMethod(context, HomePage.id);
          },
          imagePath: kGoogleImagePath,
        ),
      );
}
