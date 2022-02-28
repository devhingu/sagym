import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/member/constants/member_constants.dart';
import 'package:gym/ui/member/screens/member_detail_screen.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import '../../../widgets/member/member_tile.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({Key? key}) : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final kCurrentUser = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(kMemberEntries),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _searchField(),
                heightSizedBox(height: 15.0),
                _entryDetails(),
                heightSizedBox(height: 15.0),
                _memberStreamBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _memberStreamBuilder() =>
      StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection("Trainers")
            .doc(kCurrentUser?.email)
            .collection("memberDetails")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kBlackColor,
              ),
            );
          }
          return Flexible(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (ctx, index) {
                final doc = snapshot.data?.docs[index];
                return _memberListTile(doc!, context);
              },
            ),
          );
        },
      );

  MemberTile _memberListTile(
          QueryDocumentSnapshot<Object?> doc, BuildContext context) =>
      MemberTile(
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberDetailScreen(doc: doc),
            ),
          );
        },
        name: "${doc[paramsFirstName]} ${doc[paramsLastName]}",
        email: doc[paramsEmail],
        status: true,
        batch: doc[paramsBatch],
      );

  Row _entryDetails() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            kEntryDetails,
            style: kTextFormFieldLabelTextStyle,
          ),
          const Icon(
            kEllipsisIcon,
            color: kDarkGreyColor,
          ),
        ],
      );

  TextFormField _searchField() => TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          contentPadding: kAllSidePadding,
          border: const OutlineInputBorder(),
          hintText: kSearch,
          prefixIcon: const Icon(kSearchIcon),
          focusedBorder: const OutlineInputBorder(),
        ),
      );
}
