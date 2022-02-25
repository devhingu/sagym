import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/add_member_screen.dart';
import 'package:gym/widgets/dashboard/custom_card.dart';
import 'package:gym/widgets/dashboard/custom_data_column.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundContainer(),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(
                  top:  185,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomCard(
                      title1: "Active",
                      titleValue1: "486",
                      title2: "Inactive",
                      titleValue2: "784",
                    ),
                    heightSizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Payment Details",
                          style: kTextFormFieldLabelTextStyle,
                        ),
                        Icon(
                          kEllipsisIcon,
                          color: kGreyColor,
                        ),
                      ],
                    ),
                    heightSizedBox(height: 10.0),
                    const CustomCard(
                      title1: "Received",
                      titleValue1: "210k",
                      title2: "Due",
                      titleValue2: "130k",
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20.0),
                      decoration: kCardBoxDecoration,
                      child: const CardDataColumn(
                        title: "Due User",
                        titleValue: "30",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMemberScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Container backgroundContainer() => Container(
        padding: const EdgeInsets.all(16.0),
        height: 250,
        color: kMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeCustomAppBar(),
            heightSizedBox(height: 20.0),
            totalMembersWidget(),
            heightSizedBox(height: 10.0),
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

  Row totalMembersWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kTotalMembers, style: kTitleTextStyle),
          const Icon(
            kEllipsisIcon,
            color: kLightWhiteColor,
          ),
        ],
      );

  Row homeCustomAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Welcome, Master Kandan",
            style: kAppBarTextStyle,
          ),
          CircleAvatar(
            backgroundImage: AssetImage(kAvatarImagePath),
          )
        ],
      );
}
