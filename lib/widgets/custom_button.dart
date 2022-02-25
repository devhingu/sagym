import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';

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
        margin: kCustomButtonMargin,
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
