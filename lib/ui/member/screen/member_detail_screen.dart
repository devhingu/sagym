import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../constants/asset_constants.dart';
import '../../../constants/box_decoration_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/icon_constants.dart';
import '../../../constants/param_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../constants/text_style_constants.dart';
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
      appBar: AppBar(
        title: Text(
            "${widget.doc[paramFirstName]} ${widget.doc[paramLastName]}"),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _backgroundContainer(),
            SingleChildScrollView(
              child: Container(
                decoration: kMemberDetailBoxDecoration,
                padding: kAllSideBigPadding,
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20),
                child: _memberDataColumn(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _backgroundContainer() => Container(
        height: MediaQuery.of(context).size.height * 0.34,
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 120.0),
        color: kMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kDumbbellImagePath,
              height: MediaQuery.of(context).size.height * 0.1,
              color: kWhiteColor,
            ),
            Text(
              kTitleSaGym,
              style: kAppTitleTextStyle.copyWith(color: kWhiteColor),
            )
          ],
        ),
      );

  Column _memberDataColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userMainDetailRow(),
          _divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MemberDetailData(
                title: kHeight,
                titleValue: widget.doc[paramHeight],
              ),
              MemberDetailData(
                title: kWeight,
                titleValue: widget.doc[paramWeight],
              ),
              MemberDetailData(
                title: kDOB,
                titleValue: widget.doc[paramDob],
              ),
            ],
          ),
          _divider(),
          MemberDetailData(
            title: kAddress,
            titleValue: widget.doc[paramAddress],
          ),
          _divider(),
          MemberDetailData(
            title: kBatch,
            titleValue: widget.doc[paramBatch],
          ),
          _divider(),
          MemberDetailData(
            title: kMembershipPlan,
            titleValue: widget.doc[paramMemberShipPlan],
          ),
          _divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MemberDetailData(
                title: kAmount,
                titleValue: widget.doc[paramReceivedAmount],
              ),
              MemberDetailData(
                title: kPaymentType,
                titleValue: widget.doc[paramPaymentType],
              ),
            ],
          ),
          _divider(),
        ],
      );

  Row _userMainDetailRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 200.0,
                    child: Text(
                      "${widget.doc[paramFirstName]} ${widget.doc[paramLastName]}",
                      style: kMemberDetailNameTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  widthSizedBox(width: 5.0),
                  Icon(
                    icActiveCircle,
                    color: widget.doc[paramStatus] == true
                        ? kGreenColor
                        : kRedColor,
                  )
                ],
              ),
              _userDataRow(icon: icMail, title: widget.doc[paramEmail]),
              _userDataRow(icon: icPhone, title: widget.doc[paramPhone]),
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

  CircleAvatar _circleAvatar() =>  const CircleAvatar(
        radius: 40.0,
        backgroundImage: AssetImage(kAvatarImagePath),
      );
}
