import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';

class CardDataColumn extends StatelessWidget {
  const CardDataColumn({
    Key? key,
    required this.title,
    required this.titleValue,
  }) : super(key: key);

  final String title;
  final String titleValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: kCardTitleTextStyle),
        Text(titleValue, style: kAppTitleTextStyle),
      ],
    );
  }
}
