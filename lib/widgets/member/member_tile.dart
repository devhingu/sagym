import 'package:flutter/material.dart';
import '../../constants/asset_constants.dart';
import '../../constants/box_decoration_constants.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants.dart';
import '../../constants/icon_constants.dart';
import '../../constants/text_style_constants.dart';
import '../../utils/methods/reusable_methods.dart';

class MemberTile extends StatelessWidget {
  final VoidCallback onPress;
  final String name;
  final String email;
  final String batch;
  final bool status;

  const MemberTile({
    Key? key,
    required this.onPress,
    required this.name,
    required this.email,
    required this.status,
    required this.batch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        padding: kAllSideVerySmallPadding,
        decoration: kCardBoxDecoration,
        child: _memberTile(),
      ),
    );
  }

  ListTile _memberTile() => ListTile(
        onTap: onPress,
        leading: const CircleAvatar(
          backgroundColor: kWhiteColor,
          radius: 30.0,
          backgroundImage: AssetImage(kAvatarImagePath),
        ),
        title: Text(name, style: kMemberTileNameTextStyle),
        subtitle: _memberSubtitle(),
      );

  Column _memberSubtitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(email, style: kMemberTileTextStyle),
          heightSizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(batch, style: kMemberTileTextStyle),
              Icon(
                icActiveCircle,
                color: status == true ? kGreenColor : kRedColor,
              ),
            ],
          ),
        ],
      );
}
