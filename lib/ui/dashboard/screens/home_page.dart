import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/account/screens/user_profile_screen.dart';
import 'package:gym/ui/dashboard/screens/bottom_sheet_screen.dart';
import 'package:gym/ui/dashboard/screens/home_screen.dart';
import 'package:gym/ui/member/screens/member_list.dart';

import '../../location/screens/location_screen.dart';

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
      floatingActionButton: buildFloatingActionButton(context, size),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context, size) =>
      FloatingActionButton(
        backgroundColor: kFloatingActionButtonColor,
        child: const Icon(
          Icons.add,
          color: kWhiteColor,
          size: 30.0,
        ),
        onPressed: () {
          openBottomSheet();
        },
        elevation: 8.0,
      );

  openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      builder: (context) => const BottomSheetScreen(),
    );
  }

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
