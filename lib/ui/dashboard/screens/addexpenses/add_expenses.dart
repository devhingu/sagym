import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/addmember/add_member_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/ui/member/screens/member_list.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';

class AddExpensesScreen extends StatefulWidget {
  static const String id = "add_expenses";

  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  _AddExpensesScreenState createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final TextEditingController _gymAccessoriesNameController =
      TextEditingController();
  final TextEditingController _gymAccessoriesTypeController =
      TextEditingController();
  final TextEditingController _gymAccessoriesExpenseController =
      TextEditingController();
  final TextEditingController _gymAccessoriesAddedByController =
      TextEditingController();
  final FocusNode _gymAccessoriesNameFocusNode = FocusNode();
  final FocusNode _gymAccessoriesTypeFocusNode = FocusNode();
  final FocusNode _gymAccessoriesExpenseFocusNode = FocusNode();
  final FocusNode _gymAccessoriesAddedByFocusNode = FocusNode();
  final _fireStore = FirebaseFirestore.instance;

  final kCurrentUser = FirebaseAuth.instance.currentUser;
  String userName = "";

  Future getCurrentUser() async {
    if (kCurrentUser?.displayName == null || kCurrentUser?.displayName == "") {
      final snapshots = await _fireStore
          .collection("Trainers")
          .doc(kCurrentUser?.email)
          .collection("trainerDetails")
          .get();
      setState(() {
        _gymAccessoriesAddedByController.text =
            snapshots.docs.first.get("userName");
      });
    } else {
      try {
        if (kCurrentUser != null) {
          _gymAccessoriesAddedByController.text = kCurrentUser!.displayName!;
        }
      } catch (e) {
        debugPrint("$e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _backgroundContainer(),
              Container(
                padding: kAllSideBigPadding,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.07,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: kCardBoxDecoration,
                  child: Padding(
                    padding: kAllSidePadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Expenses Details",
                              style: kTextFormFieldTextStyle,
                            ),
                            _gymAccessoriesNameTextField(),
                            _gymAccessoriesTypeTextField(),
                            _gymAccessoriesExpenseTextField(),
                            _gymAccessoriesAddedByTextField(),
                          ],
                        ),
                        _bottomButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _bottomButton(BuildContext context) => Align(
    alignment: Alignment.center,
    child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(kFloatingActionButtonColor),
          ),
          onPressed: () async {
            // await _saveMemberDetailsToFirestore();
            Navigator.pop(context);
          },
          child: const Text(
            "Add Expense",
            style: kCustomButtonTextStyle,
          ),
        ),
  );

  TextFormFieldContainer _gymAccessoriesNameTextField() =>
      TextFormFieldContainer(
        label: "Accessories Name",
        inputType: TextInputType.text,
        controller: _gymAccessoriesNameController,
        focusNode: _gymAccessoriesNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _gymAccessoriesNameFocusNode,
              _gymAccessoriesTypeFocusNode);
        },
      );

  TextFormFieldContainer _gymAccessoriesTypeTextField() =>
      TextFormFieldContainer(
        label: "Accessories Type",
        inputType: TextInputType.text,
        controller: _gymAccessoriesTypeController,
        focusNode: _gymAccessoriesTypeFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _gymAccessoriesTypeFocusNode,
              _gymAccessoriesExpenseFocusNode);
        },
      );

  TextFormFieldContainer _gymAccessoriesExpenseTextField() =>
      TextFormFieldContainer(
        label: "Expense",
        inputType: TextInputType.text,
        controller: _gymAccessoriesExpenseController,
        focusNode: _gymAccessoriesExpenseFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _gymAccessoriesExpenseFocusNode,
              _gymAccessoriesAddedByFocusNode);
        },
      );

  TextFormFieldContainer _gymAccessoriesAddedByTextField() =>
      TextFormFieldContainer(
        label: "Added By",
        inputType: TextInputType.text,
        controller: _gymAccessoriesAddedByController,
        focusNode: _gymAccessoriesAddedByFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(context, _gymAccessoriesAddedByFocusNode);
        },
      );

  Container _backgroundContainer() => Container(
        padding: kAllSideBigPadding,
        height: MediaQuery.of(context).size.height * 0.2,
        color: kMainColor,
        child: _homeCustomAppBar(),
      );

  Row _homeCustomAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: kLightWhiteColor,
                ),
                Text(
                  kAddExpenses,
                  style: kAppBarTextStyle,
                ),
              ],
            ),
          ),
        ],
      );

/* _saveMemberDetailsToFirestore() async {
    if (_memberShipPlanController.text.trim().isNotEmpty &&
        _amountController.text.trim().isNotEmpty &&
        _paymentController.text.trim().isNotEmpty &&
        _paymentTypeController.text.trim().isNotEmpty) {
      await _fireStore
          .collection("Trainers")
          .doc(kCurrentUser?.email)
          .collection("memberDetails")
          .doc(widget.email)
          .update({
        'memberShipPlan': _memberShipPlanController.text,
        'amount': _amountController.text,
        'paymentType': _paymentTypeController.text,
        'paymentStatus': _paymentController.text,
        'staffName': _staffNameController.text,
      });
    } else {
      debugPrint("failed");
    }
    _memberShipPlanController.clear();
    _amountController.clear();
    _paymentController.clear();
    _paymentTypeController.clear();
  }*/
}
