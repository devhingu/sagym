import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/account/screen/user_profile_screen.dart';
import 'package:gym/ui/dashboard/screen/bottom_sheet_screen.dart';
import 'package:gym/ui/dashboard/screen/home_screen.dart';
import 'package:gym/ui/member/screen/member_list.dart';

import '../../location/screen/location_screen.dart';
import '../constants/dashboard_constants.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: _children[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(context, size),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context, size) =>
      FloatingActionButton(
        backgroundColor: kFloatingActionButtonColor,
        child: const Icon(
          kAddIcon,
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

  BottomNavigationBar bottomNavBar() => BottomNavigationBar(
        iconSize: 24.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGreyColor,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: kBottomNavItems,
        onTap: _onItemTapped,
      );
}
