import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/ui/dashboard/screens/add_member_screen.dart';
import 'package:gym/ui/dashboard/screens/home_screen.dart';

class HomePage extends StatefulWidget {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) =>
      FloatingActionButton(
        backgroundColor: kFloatingActionButtonColor,
        child: const Icon(
          Icons.add,
          color: kWhiteColor,
          size: 30.0,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddMemberScreen()));
        },
        elevation: 8.0,
      );

  BottomNavigationBar bottomNavBar() => BottomNavigationBar(
        iconSize: 26.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGreyColor,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2_fill), label: "Members"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.location), label: "Location"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled), label: "Account"),
        ],
        onTap: _onItemTapped,
      );
}
