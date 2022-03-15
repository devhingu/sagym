import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/constants.dart';
import '../constants/text_style_constants.dart';

class ElevatedCustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;

  const ElevatedCustomButton({
    Key? key,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kMainColor),
      ),
      onPressed: onPress,
      child: Padding(
        padding: kAllSideSmallPadding,
        child: Text(
          title,
          style: kCustomButtonTextStyle,
        ),
      ),
    );
  }
}
