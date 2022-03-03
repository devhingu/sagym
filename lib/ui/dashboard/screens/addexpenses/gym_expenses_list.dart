import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';

import '../../../../constants/color_constants.dart';
import '../../../../widgets/gym_expenses_list_tile.dart';
import '../../../account/constants/user_profile_constants.dart';

class GymExpensesList extends StatefulWidget {
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
          onRefresh:  () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection("Expenses").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kBlackColor,
                  ),
                );
              }
              return Padding(
                padding:kAllSidePadding,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, index) {
                    final doc = snapshot.data?.docs[index];
                    return GymExpenseCardTile(
                      accessoryName: doc![paramsAccessoriesName],
                      accessoryPrice: doc[paramsAccessoriesExpense],
                      accessoryType: doc[paramsAccessoriesType],
                      addedBy: doc[paramsAddedBy],
                      imagePath: doc[paramsUserProfileImage],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
