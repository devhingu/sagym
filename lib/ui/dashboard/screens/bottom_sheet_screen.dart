import 'package:flutter/material.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/addexpenses/add_expenses.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

import 'addmember/add_member_screen.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(bottom: 100.0),
      height: size.height * 1.0,
      decoration: const BoxDecoration(
        color: Colors.black54,
      ),
      child: Row(
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
            title: kAddExpenses,
            onPress: () {
              navigatePopAndPushNamedMethod(context, AddExpensesScreen.id);
            },
          ),
        ],
      ),
    );
  }

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
}
