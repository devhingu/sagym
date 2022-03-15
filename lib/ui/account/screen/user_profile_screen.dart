import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/asset_constants.dart';
import '../../../constants/box_decoration_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/icon_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../constants/text_style_constants.dart';
import '../../../provider/bottom_provider.dart';
import '../../../provider/user_detail_provider.dart';
import '../../../service/firebase_auth_service.dart';
import '../../../utils/methods/reusable_methods.dart';
import '../../../widgets/profile/user_profile_list_tile.dart';
import '../../auth/screen/changepassword/change_password.dart';
import '../../auth/screen/login/sign_in_screen.dart';
import '../../dashboard/screen/addexpenses/gym_expenses_list.dart';
import 'edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  static const String id = "user_profile_screen";

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _fireStoreInstance = FirebaseFirestore.instance;

  Future getCurrentUser() async {
    final snapshots = await _fireStoreInstance
        .collection("Trainers")
        .doc(_currentUser?.email)
        .get();

    Provider.of<UserData>(context, listen: false).updateProfile(snapshots);
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
        height: size.height * 0.30,
        decoration: kUserProfileBoxDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<UserData>(builder: (context, userData, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190.0,
                    child: Text(
                      userData.userName,
                      style: kUserNameTextStyle,
                    ),
                  ),
                  heightSizedBox(height: 10.0),
                  SizedBox(
                    width: 210.0,
                    child: Text(
                      userData.userEmail,
                      style: kUserEmailTextStyle,
                    ),
                  ),
                ],
              );
            }),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _circleAvatar(),
                heightSizedBox(height: 12.0),
                _editProfileButton()
              ],
            ),
          ],
        ),
      );

  Widget _circleAvatar() =>
      Consumer<UserData>(builder: (context, userData, child) {
        return CircleAvatar(
          radius: 53.0,
          backgroundColor: kMainColor,
          child: userData.profileImage.contains("assets/")
              ? _assetCircleAvatar()
              : userData.profileImage.isEmpty
                  ? _assetCircleAvatar()
                  : CircleAvatar(
                      radius: 50.0,
                      backgroundColor: kWhiteColor,
                      backgroundImage: NetworkImage(userData.image),
                    ),
        );
      });

  CircleAvatar _assetCircleAvatar() => const CircleAvatar(
        radius: 50.0,
        backgroundColor: kWhiteColor,
        backgroundImage: AssetImage(kAvatarImagePath),
      );

  UserProfileListTile _getGymExpenseTile() => UserProfileListTile(
        onPress: () {
          navigatePushNamedMethod(context, GymExpensesList.id);
        },
        icon: icPrice,
        title: kGymExpenses,
      );

  GestureDetector _editProfileButton() => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(
                name: Provider.of<UserData>(context).userName,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
          decoration: BoxDecoration(
            border: Border.all(color: kMainColor, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Text(
            kEditProfile,
            style: kCardTitleTextStyle,
          ),
        ),
      );

  UserProfileListTile _changePasswordTile() => UserProfileListTile(
        title: kChangePassword,
        icon: icPassword,
        onPress: () {
          navigatePushNamedMethod(context, ChangePasswordScreen.id);
        },
      );

  _logoutTile(BuildContext context) => UserProfileListTile(
        onPress: () async {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                kLogout,
                style: kMemberTileNameTextStyle,
              ),
              actions: [
                TextButton(
                  child: const Text(kCancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Consumer<UserData>(builder: (context, userData, child) {
                  return Consumer<BottomNavigationData>(
                      builder: (context, bottomData, child) {
                    return TextButton(
                      child: const Text(kLogout),
                      onPressed: () async {
                        FirebaseService firebaseService = FirebaseService();
                        await firebaseService.signOutFromFirebase();
                        final _prefs = await SharedPreferences.getInstance();
                        _prefs.setBool('isLoggedIn', false);
                        await navigatePushAndRemoveUntil(
                            context, SignInScreen.id);
                        userData.updateData();
                        bottomData.getIndex();
                      },
                    );
                  });
                }),
              ],
              content: const Text(
                "Do you Really want to logout?",
                style: kMemberTileTextStyle,
              ),
            ),
          );
        },
        title: kLogout,
        icon: icLogout,
      );

  UserProfileListTile _getHelpTile() => UserProfileListTile(
        onPress: () {},
        icon: icHelp,
        title: kGetHelp,
      );

  UserProfileListTile _getFeedbackTile() => UserProfileListTile(
        onPress: () {},
        icon: icFeedback,
        title: kGiveUsFeedback,
      );
}
