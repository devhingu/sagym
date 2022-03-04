import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/widgets/custom_button.dart';
import 'package:gym/widgets/welcome/welcome_top_image_container.dart';
import 'package:gym/constants/methods/reusable_methods.dart';

import '../../auth/screen/signup/sign_up_screen.dart';
import '../constants/welcome_constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _topSkipButton(),
              _pageView(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              _currentPage != _numPages - 1
                  ? _nextButton()
                  : _getStartedButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding _getStartedButton(BuildContext context) => Padding(
        padding: kAllSideBigPadding,
        child: CustomButton(
            title: kGetStarted,
            onPress: () {
              navigatePopAndPushNamedMethod(
                context,
                SignUpScreen.id,
              );
            }),
      );

  Padding _nextButton() => Padding(
        padding: kAllSideBigPadding,
        child: CustomButton(
            title: kNext,
            onPress: () {
              _pageController.nextPage(
                duration: kDuration,
                curve: Curves.ease,
              );
            }),
      );

  SizedBox _pageView(Size size) => SizedBox(
        height: size.height * 0.65,
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            _imageContainer1(),
            _imageContainer2(),
            _imageContainer3(),
          ],
        ),
      );

  Container _topSkipButton() => Container(
        alignment: Alignment.centerRight,
        padding: kAllSideSmallPadding,
        child: TextButton(
          onPressed: () {
            _pageController.animateToPage(
              _numPages - 1,
              duration: kDuration,
              curve: Curves.ease,
            );
          },
          child: _currentPage == _numPages - 1
              ? const Text('')
              : Text(
                  kSkip,
                  style: kLabelTextStyle,
                ),
        ),
      );

  WelcomeTopImageContainer _imageContainer3() => WelcomeTopImageContainer(
        imagePath: kGymImagePath3,
        title: kStringScreen3,
      );

  WelcomeTopImageContainer _imageContainer2() => WelcomeTopImageContainer(
        imagePath: kGymImagePath2,
        title: kStringScreen2,
      );

  WelcomeTopImageContainer _imageContainer1() => WelcomeTopImageContainer(
        imagePath: kGymImagePath1,
        title: kStringScreen1,
      );

  Widget _indicator(bool isActive) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: kAllSideSmallPadding,
        height: 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive ? kMainColor : kGreyColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      );
}
