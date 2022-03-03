import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/constants.dart';

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
        backgroundColor: MaterialStateProperty.all(kFloatingActionButtonColor),
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
