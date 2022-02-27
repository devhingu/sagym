import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/member/constants/member_constants.dart';

class MemberListTile extends StatelessWidget {
  final String name;
  final String leadingImage;
  final String subtitle;
  final VoidCallback onPress;
  final bool isReceived;

  const MemberListTile({
    Key? key,
    required this.name,
    required this.leadingImage,
    required this.onPress,
    required this.isReceived,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kTopSmallPadding,
      decoration: kCardBoxDecoration,
      child: ListTile(
        onTap: onPress,
        leading: CircleAvatar(
          radius: 19.0,
          backgroundImage: AssetImage(
            leadingImage,
          ),
          backgroundColor: kWhiteColor,
        ),
        title: Text(
          name,
        ),
        subtitle: Text(subtitle),
        trailing: Icon(
          kActiveIcon,
          color: isReceived ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
