import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/account/constants/user_profile_constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import '../../../constants/color_constants.dart';
import '../../../widgets/reminder_list_tile.dart';
import '../constants/member_constants.dart';

class ReminderScreen extends StatefulWidget {
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
        title: const Text("Reminders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore
              .collection("Trainers")
              .doc(kCurrentUser?.email)
              .collection("reminders")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kBlackColor,
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (ctx, index) {
                final doc = snapshot.data?.docs[index];
                return ReminderListTile(
                  title: doc!["reminder"],
                  dateStamp: doc["currentStamp"],
                );
              },
            );
          }),
    );
  }
}
