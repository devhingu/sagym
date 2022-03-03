import 'package:flutter/material.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import '../constants/constants.dart';
import '../ui/account/constants/user_profile_constants.dart';
import '../ui/dashboard/constants/dashboard_constants.dart';
import '../ui/member/constants/member_constants.dart';

class ReminderListTile extends StatelessWidget {
  final String title;
  final String dateStamp;

  const ReminderListTile({
    Key? key,
    required this.title,
    required this.dateStamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kAllSideSmallPadding,
      padding: kAllSidePadding,
      decoration: kCardBoxDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: kMemberTileNameTextStyle.copyWith(fontSize: 18.0),
                ),
              ),
              widthSizedBox(width: 15.0),
              const Icon(Icons.notifications_active_outlined)
            ],
          ),
          const Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              dateStamp,
              style: kUserEmailTextStyle.copyWith(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
