import 'package:flutter/material.dart';
import '../../constants/box_decoration_constants.dart';
import '../../constants/constants.dart';
import '../../constants/text_style_constants.dart';
import '../../utils/methods/reusable_methods.dart';

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
      child: _reminderDataColumn(),
    );
  }

  Column _reminderDataColumn() => Column(
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
      );
}
