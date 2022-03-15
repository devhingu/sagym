import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_style_constants.dart';

class AuthCustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final String imagePath;

  const AuthCustomButton({
    Key? key,
    required this.title,
    required this.onPress,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Image.asset(
        imagePath,
        height: 30.0,
        width: 25.0,
      ),
      onPressed: onPress,
      label: Text(
        title,
        style: kAuthButtonTextStyle,
      ),
      style: ElevatedButton.styleFrom(
        primary: kWhiteColor,
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }
}
