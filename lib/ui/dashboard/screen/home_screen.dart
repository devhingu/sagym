import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/provider/member_provider.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/widgets/dashboard/custom_card.dart';
import 'package:gym/widgets/dashboard/custom_data_column.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/methods/reusable_methods.dart';

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
  String imagePath = "";
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
    if (user?.displayName == null || user?.displayName == "") {
      final snapshots =
          await _fireStore.collection("Trainers").doc(user?.email).get();
      setState(() {
        userName = snapshots.get("userName");
        imagePath = "";
      });
    } else {
      try {
        if (user != null) {
          userName = user!.displayName!;
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
            getCurrentData();
          },
          child: SingleChildScrollView(
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
        child: Consumer<MemberData>(
          builder: (BuildContext context, memberData, Widget? child) {
            return CardDataColumn(
              title: kDueUsers,
              titleValue: memberData.dueUserCounts.toString(),
            );
          },
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

  Consumer _activeInactiveCard() => Consumer<MemberData>(
          builder: (BuildContext context, memberData, Widget? child) {
        return CustomCard(
          title1: kActive,
          titleValue1: memberData.activeCounts.toString(),
          title2: kInactive,
          titleValue2: memberData.inActiveCounts.toString(),
        );
      });

  Consumer _receivedDueCard() => Consumer<MemberData>(
        builder: (BuildContext context, memberData, Widget? child) {
          return CustomCard(
            title1: kReceived,
            titleValue1:
                NumberFormat.compact().format(memberData.receivedAmounts),
            title2: kDue,
            titleValue2: NumberFormat.compact().format(memberData.dueAmounts),
          );
        },
      );

  Container _backgroundContainer() => Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.32,
        color: kMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _homeCustomAppBar(),
            Expanded(child: _totalMembersWidget()),
            Expanded(
              child: Consumer<MemberData>(
                builder: (BuildContext context, memberData, Widget? child) {
                  return Text(
                    memberData.totalUsers.toString(),
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

  Row _totalMembersWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kTotalMembers, style: kTitleTextStyle),
          const Icon(
            kEllipsisIcon,
            color: kLightWhiteColor,
          ),
        ],
      );

  Padding _homeCustomAppBar() => Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                width: 180.0,
                child: FittedBox(
                  child: Text(
                    "$kWelcome $userName",
                    style: kAppBarTextStyle.copyWith(fontSize: 22.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            widthSizedBox(width: 10.0),
            imagePath.isEmpty
                ? const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(kAvatarImagePath),
                  )
                : CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(imagePath),
                  )
          ],
        ),
      );
}
