import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/ui/auth/login/sign_in_screen.dart';
import 'package:gym/ui/auth/login/sign_up_screen.dart';
import 'package:gym/ui/home_screen.dart';

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
    const SignInScreen(),
    const SignUpScreen(),
    const HomeScreen(),
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
          color: kBlackColor,
          size: 30.0,
        ),
        onPressed: () {},
      );

  BottomNavigationBar bottomNavBar() => BottomNavigationBar(
    iconSize: 32.0,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white54,
    currentIndex: _selectedIndex,
    backgroundColor: kBlackColor,
    type: BottomNavigationBarType.fixed,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home"
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Profile"
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.camera),
        label: "Camera"
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: "Camera"
      ),
    ],
    onTap: _onItemTapped,
  );
}
