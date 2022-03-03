import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/service/list_provider.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/widgets/dashboard/custom_card.dart';
import 'package:gym/widgets/dashboard/custom_data_column.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../widgets/reusable/reusable_methods.dart';

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

  void getCurrentDate(){
    DateTime now = DateTime.now();
    day =
    "${DateFormat('EEEE').format(now)}, ${DateFormat("MMMM").format(now)} ${now.day}, ${now.year}";
  }

  @override
  void initState() {
    super.initState();
    getCurrentData(context);
    getCurrentUser();
    getCurrentDate();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            getCurrentData(context);
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
        child: CardDataColumn(
          title: kDueUsers,
          titleValue: Provider.of<MemberData>(context).dueUserCounts.toString(),
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
        titleValue1: Provider.of<MemberData>(context).activeCounts.toString(),
        title2: kInactive,
        titleValue2: Provider.of<MemberData>(context).inActiveCounts.toString(),
      );

  CustomCard _receivedDueCard() => CustomCard(
        title1: kReceived,
        titleValue1: NumberFormat.compact()
            .format(Provider.of<MemberData>(context).receivedAmounts),
        title2: kDue,
        titleValue2: NumberFormat.compact()
            .format(Provider.of<MemberData>(context).dueAmounts),
      );

  Container _backgroundContainer() => Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.32,
        color: kMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _homeCustomAppBar()),
            Expanded(child: _totalMembersWidget()),
            Expanded(
              child: Text(
                Provider.of<MemberData>(context).totalUsers.toString(),
                style: kMemberCountTextStyle,
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
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "$kWelcome $userName",
                style: kAppBarTextStyle.copyWith(fontSize: 22.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            imagePath.isEmpty
                ? const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage(kAvatarImagePath),
                  )
                : CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(imagePath),
                  )
          ],
        ),
      );
}
