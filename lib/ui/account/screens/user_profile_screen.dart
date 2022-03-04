import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/service/firebase_auth_service.dart';
import 'package:gym/ui/auth/screens/change_password.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/addexpenses/gym_expenses_list.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import '../../../widgets/profile/user_profile_list_tile.dart';
import '../../member/constants/member_constants.dart';
import '../constants/user_profile_constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;
  String userName = "";
  String email = "";
  String imagePath = "";

  Future getCurrentUser() async {
    if (user?.displayName == null || user?.displayName == "") {
      final snapshots =
          await _fireStore.collection("Trainers").doc(user?.email).get();
      setState(() {
        userName = snapshots.get("userName");
        email = snapshots.get("email");
        imagePath = "";
      });
    } else {
      try {
        if (user != null) {
          userName = user!.displayName!;
          email = user!.email!;
          imagePath = user!.photoURL!;
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
            Container(
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
            ),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen()));
        },
      );

  UserProfileListTile _getGymExpenseTile() => UserProfileListTile(
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GymExpensesList(),
            ),
          );
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
