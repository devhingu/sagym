import 'package:flutter/material.dart';
import '../constants/box_decoration_constants.dart';
import '../constants/text_style_constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 55.0,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16.0),
        decoration: kCustomButtonBoxDecoration,
        child: Center(
          child: Text(
            title,
            style: kCustomButtonTextStyle
          ),
        ),
      ),
    );
  }
}
