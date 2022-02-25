import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';

class TopLogoTitleWidget extends StatelessWidget {
  const TopLogoTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            kDumbbellImagePath,
            height: 70.0,
            color: kMainColor,
          ),
          Text(
            kTitleBodyFitGym,
            style: kAppTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
