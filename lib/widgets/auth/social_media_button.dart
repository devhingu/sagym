import 'package:flutter/cupertino.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import 'auth_custom_button.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kAuthPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: AuthCustomButton(
              title: kGoogle,
              onPress: () {},
              imagePath: kGoogleImagePath,
            ),
          ),
          widthSizedBox(width: 20.0),
          Expanded(
            flex: 1,
            child: AuthCustomButton(
              title: kFacebook,
              onPress: () {},
              imagePath: kFacebookImagePath,
            ),
          ),
        ],
      ),
    );
  }
}
