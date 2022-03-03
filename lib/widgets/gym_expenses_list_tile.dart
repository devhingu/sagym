import 'package:flutter/material.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import '../constants/constants.dart';
import '../ui/account/constants/user_profile_constants.dart';
import '../ui/dashboard/constants/dashboard_constants.dart';
import '../ui/member/constants/member_constants.dart';

class GymExpenseCardTile extends StatelessWidget {
  final String accessoryName;
  final String accessoryType;
  final String accessoryPrice;
  final String addedBy;
  final String imagePath;

  const GymExpenseCardTile({
    Key? key,
    required this.accessoryName,
    required this.accessoryType,
    required this.accessoryPrice,
    required this.addedBy,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kAllSideSmallPadding,
      margin: kTBottomPadding,
      decoration: kCardBoxDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            accessoryName,
            style: kMemberTileNameTextStyle,
          ),
          const Divider(),
          Text(
            accessoryType,
            style: kUserEmailTextStyle,
          ),
          Text(accessoryPrice, style: kMemberTileNameTextStyle),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Text(
                "~",
                style: kMemberTileTextStyle.copyWith(fontSize: 22.0),
              ),
              widthSizedBox(width: 5.0),
              Row(
                children: [
                  imagePath.contains("assets/", 0)
                      ? CircleAvatar(
                          backgroundImage: AssetImage(imagePath),
                          radius: 15.0,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(imagePath),
                          radius: 15.0,
                        ),
                  widthSizedBox(width: 5.0),
                  Text(
                    addedBy,
                    style: kMemberTileTextStyle,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
