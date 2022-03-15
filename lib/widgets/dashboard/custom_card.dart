import 'package:flutter/material.dart';
import '../../constants/box_decoration_constants.dart';
import 'custom_data_column.dart';

class CustomCard extends StatelessWidget {
  final String title1;
  final String title2;
  final String titleValue1;
  final String titleValue2;

  const CustomCard({
    Key? key,
    required this.title1,
    required this.title2,
    required this.titleValue1,
    required this.titleValue2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: kCardBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: CardDataColumn(title: title1, titleValue: titleValue1)),
          verticalDivider(),
          Expanded(
              child: CardDataColumn(title: title2, titleValue: titleValue2)),
        ],
      ),
    );
  }

  SizedBox verticalDivider() => const SizedBox(
        height: 60.0,
        child: VerticalDivider(
          thickness: 2.0,
        ),
      );
}
