import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/constants.dart';
import '../../../constants/icon_constants.dart';
import '../../../provider/bottom_provider.dart';
import '../../account/screen/user_profile_screen.dart';
import '../../location/screen/location_screen.dart';
import '../../member/screen/member_list.dart';
import 'bottom_sheet_screen.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _children = [
    const HomeScreen(),
    const MemberListScreen(),
    const LocationScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _children[Provider.of<BottomNavigationData>(context).getSelectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(context, size),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context, size) =>
      FloatingActionButton(
        backgroundColor: kMainColor,
        child: const Icon(
          icAdd,
          color: kWhiteColor,
          size: 30.0,
        ),
        onPressed: () {
          openBottomSheet();
        },
        elevation: 8.0,
      );

  openBottomSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        builder: (context) => const BottomSheetScreen(),
      );

  Widget bottomNavBar() => Consumer<BottomNavigationData>(
        builder: (context, selectedIndex, child) {
          return BottomNavigationBar(
            iconSize: 24.0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: kMainColor,
            unselectedItemColor: kGreyColor,
            currentIndex: selectedIndex.getSelectedIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: kBottomNavItems,
            onTap: (index) {
              selectedIndex.setUpdatedIndex(index);
            },
          );
        },
      );
}
