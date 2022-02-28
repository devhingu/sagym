import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/member/constants/member_constants.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import '../../../widgets/member/member_detail_data.dart';

class MemberDetailScreen extends StatefulWidget {
  final dynamic doc;

  const MemberDetailScreen({Key? key, required this.doc}) : super(key: key);

  @override
  _MemberDetailScreenState createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _backgroundContainer(),
            SingleChildScrollView(
              child: Container(
                decoration: kMemberDetailBoxDecoration,
                padding: kAllSideBigPadding,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _userMainDetailRow(),
                    _divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MemberDetailData(
                          title: kHeight,
                          titleValue: widget.doc[paramsHeight],
                        ),
                        MemberDetailData(
                          title: kWeight,
                          titleValue: widget.doc[paramsWeight],
                        ),
                        MemberDetailData(
                          title: kDOB,
                          titleValue: widget.doc[paramsDob],
                        ),
                      ],
                    ),
                    _divider(),
                    MemberDetailData(
                      title: kAddress,
                      titleValue: widget.doc[paramsAddress],
                    ),
                    _divider(),
                    MemberDetailData(
                      title: kBatch,
                      titleValue: widget.doc[paramsBatch],
                    ),
                    _divider(),
                    MemberDetailData(
                      title: kMembershipPlan,
                      titleValue: widget.doc[paramsMemberShipPlan],
                    ),
                    _divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MemberDetailData(
                          title: kAmount,
                          titleValue: widget.doc[paramsAmount],
                        ),
                        MemberDetailData(
                          title: kPaymentType,
                          titleValue: widget.doc[paramsPaymentType],
                        ),
                      ],
                    ),
                    _divider(),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _userMainDetailRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${widget.doc[paramsFirstName]} ${widget.doc[paramsLastName]}",
                    style: kMemberDetailNameTextStyle,
                  ),
                  const Icon(kActiveCircleIcon, color: kGreenColor,)
                ],
              ),
              _userDataRow(icon: kMailIcon, title: widget.doc[paramsEmail]),
              _userDataRow(icon: kPhoneIcon, title: widget.doc[paramsPhone]),
            ],
          ),
          _circleAvatar(),
        ],
      );

  Padding _divider() => const Padding(
        padding: kSmallHorizontalPadding,
        child: Divider(),
      );

  Row _userDataRow({required IconData icon, required String title}) => Row(
        children: [
          Icon(
            icon,
            color: kDarkGreyColor,
            size: 18.0,
          ),
          widthSizedBox(width: 12.0),
          Text(
            title,
            style: kMemberTileTextStyle,
          ),
        ],
      );

  CircleAvatar _circleAvatar() => const CircleAvatar(
        radius: 40.0,
        backgroundImage: AssetImage(kAvatarImagePath),
      );

  Container _backgroundContainer() => Container(
        height: 300.0,
        decoration: kBackgroundDecoration,
      );
}
