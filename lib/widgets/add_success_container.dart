import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/icon_constants.dart';
import '../constants/text_style_constants.dart';

class AddSuccessContainer extends StatelessWidget {
  final String message;

  const AddSuccessContainer({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: kBackgroundColor,
              radius: 30.0,
              child: Icon(
                icCheck,
                color: kGreenColor,
                size: 35.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: kMemberAddedTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
