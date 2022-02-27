import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/add_member_screen.dart';
import 'package:gym/widgets/dashboard/custom_card.dart';
import 'package:gym/widgets/dashboard/custom_data_column.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  String userName = "";

  Future getCurrentUser() async {
    if (user?.displayName == null || user?.displayName == "") {
      final snapshots = await _fireStore
          .collection("Trainers")
          .doc(user?.email)
          .collection("trainerDetails")
          .get();
      setState(() {
        userName = snapshots.docs.first.get("userName");
      });
    } else {
      try {
        if (user != null) {
          userName = user!.displayName!;
        }
      } catch (e) {
        print(e);
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
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                _backgroundContainer(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(
                    top: 185,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _activeInactiveCard(),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: _paymentDetails(),
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

  Container _dueUserCard() => Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20.0),
        decoration: kCardBoxDecoration,
        child: CardDataColumn(
          title: kDueUsers,
          titleValue: "30",
        ),
      );

  Row _paymentDetails() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            kPaymentDetails,
            style: kTextFormFieldLabelTextStyle,
          ),
          const Icon(
            kEllipsisIcon,
            color: kGreyColor,
          ),
        ],
      );

  CustomCard _activeInactiveCard() => CustomCard(
        title1: kActive,
        titleValue1: "486",
        title2: kInactive,
        titleValue2: "784",
      );

  CustomCard _receivedDueCard() => CustomCard(
        title1: kReceived,
        titleValue1: "210k",
        title2: kDue,
        titleValue2: "130k",
      );

  Container _backgroundContainer() => Container(
        padding: const EdgeInsets.all(16.0),
        height: 250,
        color: kMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _homeCustomAppBar(),
            _totalMembersWidget(),
            const Text(
              "1270",
              style: kMemberCountTextStyle,
            ),
            const Text(
              "WED, April 03, 2019",
              style: kDateTextStyle,
            ),
          ],
        ),
      );

  Padding _totalMembersWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(kTotalMembers, style: kTitleTextStyle),
            const Icon(
              kEllipsisIcon,
              color: kLightWhiteColor,
            ),
          ],
        ),
      );

  Padding _homeCustomAppBar() => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 280.0,
              child: Text(
                "$kWelcome $userName",
                style: kAppBarTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const CircleAvatar(
              backgroundImage: AssetImage(kAvatarImagePath),
            )
          ],
        ),
      );
}
