import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constants/asset_constants.dart';
import '../../../constants/box_decoration_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../constants/text_style_constants.dart';
import '../../../provider/bottom_provider.dart';
import '../../../provider/member_provider.dart';
import '../../../provider/user_detail_provider.dart';
import '../../../widgets/dashboard/custom_card.dart';
import '../../../widgets/dashboard/custom_data_column.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  String day = "";

  void getCurrentDate() {
    DateTime now = DateTime.now();
    day =
        "${DateFormat('EEEE').format(now)}, ${DateFormat("MMMM").format(now)} ${now.day}, ${now.year}";
  }

  Future getCurrentData() async {
    var snapshot = _fireStore
        .collection("Trainers")
        .doc(user?.email)
        .collection("memberDetails")
        .snapshots();

    snapshot.forEach((element) {
      Provider.of<MemberData>(context, listen: false)
          .updateAmount(element.docs);
      Provider.of<MemberData>(context, listen: false)
          .updateUserStatus(element.docs);
    });
  }

  Future getCurrentUser() async {
    final snapshots =
        await _fireStore.collection("Trainers").doc(user?.email).get();

    Provider.of<UserData>(context, listen: false).updateProfile(snapshots);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getCurrentDate();
    getCurrentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            getCurrentUser();
            getCurrentDate();
            getCurrentData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                _backgroundContainer(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _activeInactiveCard(),
                      const Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Text(
                          kPaymentDetails,
                          style: kTextFormFieldLabelTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: _receivedDueCard(),
                      ),
                      _dueUserCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _backgroundContainer() => Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.32,
        color: kMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _homeCustomAppBar(),
            const Expanded(
              child: Text(kTotalMembers, style: kTitleTextStyle),
            ),
            Expanded(
              child: Consumer<MemberData>(
                builder: (BuildContext context, memberData, Widget? child) {
                  return Text(
                    memberData.getTotalUsers.toString(),
                    style: kMemberCountTextStyle,
                  );
                },
              ),
            ),
            Expanded(
              child: Text(
                day,
                style: kDateTextStyle,
              ),
            ),
          ],
        ),
      );

  Padding _homeCustomAppBar() => Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Consumer<UserData>(
          builder: (context, userData, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "$kWelcome ${userData.userName}",
                    style: kAppBarTextStyle.copyWith(fontSize: 22.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Consumer<BottomNavigationData>(
                    builder: (context, bottomData, child) {
                  return userData.image.contains("assets/")
                      ? GestureDetector(
                          onTap: () {
                            bottomData.setUpdatedIndex(3);
                          },
                          child: const CircleAvatar(
                            radius: 20.0,
                            backgroundImage: AssetImage(kAvatarImagePath),
                          ),
                        )
                      : userData.profileImage.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                bottomData.setUpdatedIndex(3);
                              },
                              child: const CircleAvatar(
                                radius: 20.0,
                                backgroundImage: AssetImage(kAvatarImagePath),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                bottomData.setUpdatedIndex(3);
                              },
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundImage:
                                    NetworkImage(userData.profileImage),
                              ),
                            );
                }),
              ],
            );
          },
        ),
      );

  Consumer _activeInactiveCard() => Consumer<MemberData>(
          builder: (BuildContext context, memberData, Widget? child) {
        return CustomCard(
          title1: kActive,
          titleValue1: memberData.getActiveCounts.toString(),
          title2: kInactive,
          titleValue2: memberData.getInActiveCounts.toString(),
        );
      });

  Consumer _receivedDueCard() => Consumer<MemberData>(
        builder: (BuildContext context, memberData, Widget? child) {
          return CustomCard(
            title1: kReceived,
            titleValue1:
                NumberFormat.compact().format(memberData.getReceivedAmounts),
            title2: kDue,
            titleValue2: NumberFormat.compact().format(memberData.getDueAmounts),
          );
        },
      );

  Container _dueUserCard() => Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20.0),
        decoration: kCardBoxDecoration,
        child: Consumer<MemberData>(
          builder: (BuildContext context, memberData, Widget? child) {
            return CardDataColumn(
              title: kDueUsers,
              titleValue: memberData.getDueUserCounts.toString(),
            );
          },
        ),
      );
}
