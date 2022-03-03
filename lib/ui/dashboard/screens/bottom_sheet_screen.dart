import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/addexpenses/add_expenses.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:intl/intl.dart';

import '../../../widgets/elevated_custom_button.dart';
import 'addmember/add_member_screen.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({Key? key}) : super(key: key);

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(bottom: 100.0),
      height: size.height * 1.0,
      decoration: const BoxDecoration(
        color: Colors.black54,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bottomSheetCard(
            title: kSendReminder,
            onPress: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                elevation: 15.0,
                isScrollControlled: true,
                barrierColor: Colors.black.withAlpha(1),
                builder: (context) => Container(
                  margin: kAllSideBigPadding,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: _bottomCardDataColumn(context),
                ),
              );
            },
          ),
          heightSizedBox(height: 20.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              bottomSheetCard(
                title: kAddMember,
                onPress: () {
                  navigatePopAndPushNamedMethod(context, AddMemberScreen.id);
                },
              ),
              bottomSheetCard(
                title: kAddExpense,
                onPress: () {
                  navigatePopAndPushNamedMethod(context, AddExpensesScreen.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _bottomCardDataColumn(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kSendReminder,
                style: kAppTitleTextStyle,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          TextFormField(
            controller: _messageController,
            maxLines: 6,
            style: kTextFormFieldTextStyle,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              border: textFormFieldInputBorder(),
              hintText: "Message",
              labelStyle: kTextFormFieldLabelTextStyle,
              focusedBorder: textFormFieldInputBorder(),
            ),
          ),
          heightSizedBox(height: 10.0),
          ElevatedCustomButton(
            onPress: () async {
              await _saveReminderDataToFirebase();
              Navigator.pop(context);
            },
            title: kSendReminder,
          ),
        ],
      );

  GestureDetector bottomSheetCard(
          {required VoidCallback onPress, required String title}) =>
      GestureDetector(
        onTap: onPress,
        child: Container(
          height: 100.0,
          width: 140.0,
          decoration: kCardBoxDecoration,
          child: Center(
            child: Text(
              title,
              style: kTextStyle,
            ),
          ),
        ),
      );

  _saveReminderDataToFirebase() async {
    final kCurrentUser = FirebaseAuth.instance.currentUser;
    final _fireStore = FirebaseFirestore.instance;
    String currentDate ="~ ${DateFormat.yMEd().add_jm().format(DateTime.now())}";

    if (_messageController.text.trim().isNotEmpty) {
      await _fireStore
          .collection("Trainers")
          .doc(kCurrentUser?.email)
          .collection("reminders")
          .add({
        "reminder": _messageController.text,
        "currentStamp": currentDate,
      });
    }
    _messageController.clear();
  }
}
