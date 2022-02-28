import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class MemberDetailData extends StatelessWidget {
  final String title;
  final String titleValue;

  const MemberDetailData({
    Key? key,
    required this.title,
    required this.titleValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextFormFieldLabelTextStyle,
        ),
        Text(
          titleValue,
          style: kAppTitleTextStyle,
        ),
      ],
    );
  }
}
