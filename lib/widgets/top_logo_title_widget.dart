import 'package:flutter/material.dart';
import '../constants/asset_constants.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../constants/text_style_constants.dart';

class TopLogoTitleWidget extends StatelessWidget {
  const TopLogoTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 40.0, right: 8.0, left: 8.0),
      child: Column(
        children: [
          Image.asset(
            kDumbbellImagePath,
            height: 70.0,
            color: kMainColor,
          ),
          const Text(
            kTitleSaGym,
            style: kAppTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
