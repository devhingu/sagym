import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/asset_constants.dart';
import '../../constants/string_constants.dart';
import '../../service/firebase_auth_service.dart';
import '../../ui/dashboard/screen/home_page.dart';
import '../../utils/methods/reusable_methods.dart';
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

  Expanded _googleButton(BuildContext context) => Expanded(
        flex: 1,
        child: AuthCustomButton(
          title: kGoogle,
          onPress: () async {
            FirebaseService firebaseService = FirebaseService();
            await firebaseService.signInWithGoogle();
            final _prefs = await SharedPreferences.getInstance();
            _prefs.setBool('isLoggedIn', true);
            navigatePushReplacementMethod(context, HomePage.id);
          },
          imagePath: kGoogleImagePath,
        ),
      );

  Expanded _facebookButton(BuildContext context) => Expanded(
        flex: 1,
        child: AuthCustomButton(
          title: kFacebook,
          onPress: () async {
            FirebaseService firebaseService = FirebaseService();
            await firebaseService.signInWithFacebook();
            final _prefs = await SharedPreferences.getInstance();
            _prefs.setBool('isLoggedIn', true);
            navigatePushReplacementMethod(context, HomePage.id);
          },
          imagePath: kFacebookImagePath,
        ),
      );
}
