import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/member/constants/member_constants.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

class MemberDetailScreen extends StatelessWidget {
  const MemberDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dev Hingu"),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: kAllSidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _userNameAvatar(),
                const Text(
                  "DEV HINGU",
                  style: kNameTextStyle,
                ),
                heightSizedBox(height: 15.0),
                Container(
                  decoration: kCardBoxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _personalDetails(),
                      _emailTile(),
                      _phoneTile(),
                      _dobTile(),
                      _addressTile(),
                      _heightTile(),
                      _weightTile(),
                    ],
                  ),
                ),
                heightSizedBox(height: 25.0),
                Container(
                  decoration: kMemberShipCardBoxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _membershipDetails(),
                      _planTile(),
                      _amountTile(),
                      _paymentTile(),
                      _trainerTile(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile _paymentTile() => ListTile(
        leading: SizedBox(
          width: 70.0,
          child: Text(
            kPayment,
            style: kListTileTextStyle,
          ),
        ),
        title: const Text(
          "Success!",
          style: kListTileTextStyle,
        ),
      );

  ListTile _trainerTile() => const ListTile(
        leading: SizedBox(
          width: 70.0,
          child: Text(
            kTrainer,
            style: kListTileTextStyle,
          ),
        ),
        title: Text(
          "Dev Hingu",
          style: kListTileTextStyle,
        ),
      );

  ListTile _amountTile() => ListTile(
        leading: SizedBox(
          width: 70.0,
          child: Text(
            kAmount,
            style: kListTileTextStyle,
          ),
        ),
        title: const Text(
          "500Rs.",
          style: kListTileTextStyle,
        ),
      );

  ListTile _planTile() => const ListTile(
        leading: SizedBox(
          width: 70.0,
          child: Text(
            kPlan,
            style: kListTileTextStyle,
          ),
        ),
        title: Text(
          "Silver",
          style: kListTileTextStyle,
        ),
      );

  Padding _membershipDetails() => Padding(
        padding: kAllSidePadding,
        child: Text(
          kMembershipDetails,
          style: kAppBarTextStyle,
        ),
      );

  ListTile _weightTile() => const ListTile(
        leading: Icon(kWeightIcon),
        title: Text("50kg"),
      );

  ListTile _heightTile() => const ListTile(
        leading: Icon(kHeightIcon),
        title: Text("180cm"),
      );

  ListTile _addressTile() => const ListTile(
        leading: Icon(kAddressIcon),
        title: Text("I-106, Bhojaldham Resideny, Nikol, Ahmedabad."),
      );

  ListTile _dobTile() => const ListTile(
        leading: Icon(kDobIcon),
        title: Text("WED, APRIL 2019"),
      );

  ListTile _phoneTile() => const ListTile(
        leading: Icon(kPhoneIcon),
        title: Text("+91 9067830621"),
      );

  ListTile _emailTile() => const ListTile(
        leading: Icon(kEmailIcon),
        title: Text("devhingu@gmail.com"),
      );

  Padding _personalDetails() => Padding(
        padding: kAllSidePadding,
        child: Text(
          kPersonalDetails,
          style: kTextFormFieldLabelTextStyle,
        ),
      );

  CircleAvatar _userNameAvatar() => const CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.orangeAccent,
        child: Text(
          "D",
          style: kNameFirstTextStyle,
        ),
      );
}
