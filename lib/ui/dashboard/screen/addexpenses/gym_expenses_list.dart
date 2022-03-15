import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/param_constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../widgets/gym_expenses_list_tile.dart';

class GymExpensesList extends StatefulWidget {
  static const String id = "gym_expenses_screen";

  const GymExpensesList({Key? key}) : super(key: key);

  @override
  State<GymExpensesList> createState() => _GymExpensesListState();
}

class _GymExpensesListState extends State<GymExpensesList> {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kGymExpenses),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: _gymStreamBuilder(),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _gymStreamBuilder() =>
      StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection("Expenses").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kBlackColor,
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Image.asset(kNoDataImagePath),
            );
          }
          return Padding(
            padding: kAllSidePadding,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (ctx, index) {
                final doc = snapshot.data?.docs[index];
                return _gymExpenseCardTile(doc);
              },
            ),
          );
        },
      );

  GymExpenseCardTile _gymExpenseCardTile(dynamic doc) => GymExpenseCardTile(
        accessoryName: doc![paramAccessoriesName],
        accessoryPrice: doc[paramAccessoriesExpense],
        accessoryType: doc[paramAccessoriesType],
        addedBy: doc[paramAddedBy],
        imagePath: doc[paramUserProfileImage],
      );
}
