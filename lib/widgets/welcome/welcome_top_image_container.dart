import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/constants/methods/reusable_methods.dart';

class WelcomeTopImageContainer extends StatelessWidget {
  final String title;
  final String imagePath;

  const WelcomeTopImageContainer({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              imagePath,
              height: size.height * 0.35,
            ),
          ),
          heightSizedBox(height: 30.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: kAppTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
