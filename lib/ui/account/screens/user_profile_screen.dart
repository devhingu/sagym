import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/service/firebase_auth_service.dart';
import 'package:gym/ui/auth/screens/changepassword/change_password.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/addexpenses/gym_expenses_list.dart';
import 'package:gym/constants/methods/reusable_methods.dart';
import '../../../widgets/profile/user_profile_list_tile.dart';
import '../constants/user_profile_constants.dart';

class UserProfileScreen extends StatefulWidget {
  static const String id = "user_profile_screen";

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _fireStoreInstance = FirebaseFirestore.instance;
  String userName = "";
  String email = "";
  String imagePath = "";

  Future getCurrentUser() async {
    if (_currentUser?.displayName == null || _currentUser?.displayName == "") {
      final snapshots = await _fireStoreInstance
          .collection("Trainers")
          .doc(_currentUser?.email)
          .get();
      setState(() {
        userName = snapshots.get("userName");
        email = snapshots.get("email");
        imagePath = "";
      });
    } else {
      try {
        if (_currentUser != null) {
          userName = _currentUser!.displayName!;
          email = _currentUser!.email!;
          imagePath = _currentUser!.photoURL!;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(kUserProfile),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _topContainer(size),
            heightSizedBox(height: 10.0),
            Column(
              children: [
                _getGymExpenseTile(),
                _changePasswordTile(),
                _logoutTile(context),
                _getHelpTile(),
                _getFeedbackTile(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _topContainer(Size size) => Container(
        padding: const EdgeInsets.all(16.0),
        width: size.width,
        height: size.height * 0.25,
        decoration: kUserProfileBoxDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _userNameText(),
                heightSizedBox(height: 10.0),
                _emailText(),
              ],
            ),
            _circleAvatar(),
          ],
        ),
      );

  UserProfileListTile _getFeedbackTile() => UserProfileListTile(
        onPress: () {},
        icon: kFeedbackIcon,
        title: kGiveUsFeedback,
      );

  UserProfileListTile _getHelpTile() => UserProfileListTile(
        onPress: () {},
        icon: kHelpIcon,
        title: kGetHelp,
      );

  _logoutTile(BuildContext context) => UserProfileListTile(
        onPress: () async {
          FirebaseService firebaseService = FirebaseService();
          await firebaseService.signOutFromFirebase();
          navigatePushReplacementMethod(context, SignInScreen.id);
        },
        title: kLogout,
        icon: kLogoutIcon,
      );

  UserProfileListTile _changePasswordTile() => UserProfileListTile(
        title: kChangePassword,
        icon: kPasswordIcon,
        onPress: () {
          navigatePushNamedMethod(context, ChangePasswordScreen.id);
        },
      );

  UserProfileListTile _getGymExpenseTile() => UserProfileListTile(
        onPress: () {
          navigatePushNamedMethod(context, GymExpensesList.id);
        },
        icon: kPriceIcon,
        title: kGymExpenses,
      );

  CircleAvatar _circleAvatar() => CircleAvatar(
        radius: 53.0,
        backgroundColor: kMainColor,
        child:
            imagePath.isEmpty ? _assetCircleAvatar() : _networkCircleAvatar(),
      );

  CircleAvatar _networkCircleAvatar() => CircleAvatar(
        radius: 50.0,
        backgroundColor: kWhiteColor,
        backgroundImage: NetworkImage(imagePath),
      );

  CircleAvatar _assetCircleAvatar() => const CircleAvatar(
        radius: 50.0,
        backgroundColor: kWhiteColor,
        backgroundImage: AssetImage(kAvatarImagePath),
      );

  Text _emailText() => Text(
        email,
        style: kUserEmailTextStyle,
      );

  SizedBox _userNameText() => SizedBox(
        width: 220.0,
        child: Text(
          userName,
          style: kUserNameTextStyle,
        ),
      );
}
