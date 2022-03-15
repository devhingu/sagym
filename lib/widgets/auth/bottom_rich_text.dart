import 'package:flutter/material.dart';
import '../../constants/text_style_constants.dart';

class BottomRichText extends StatelessWidget {
  final String startText;
  final String endText;
  final VoidCallback onPress;

  const BottomRichText({
    Key? key,
    required this.startText,
    required this.endText,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            text: startText,
            style: kBottomStartTextStyle,
            children: [
              TextSpan(
                  text: endText,
                  style: kBottomEndTextStyle
              ),
            ],
          ),
        ),
      ),
    );
  }
}