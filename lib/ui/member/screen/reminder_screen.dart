import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/asset_constants.dart';
import '../../../constants/param_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../utils/methods/reusable_methods.dart';
import '../../../widgets/member/reminder_list_tile.dart';

class ReminderScreen extends StatefulWidget {
  static const String id = "reminder_screen";

  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final kCurrentUser = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kReminders),
      ),
      body: _reminderStreamBuilder(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _reminderStreamBuilder() =>
      StreamBuilder<QuerySnapshot>(
          stream: _fireStore
              .collection("Trainers")
              .doc(kCurrentUser?.email)
              .collection("reminders")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return customCircularIndicator();
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Image.asset(kNoDataImagePath),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (ctx, index) {
                final doc = snapshot.data?.docs[index];
                return ReminderListTile(
                  title: doc![paramReminder],
                  dateStamp: doc[paramCurrentStamp],
                );
              },
            );
          });
}
