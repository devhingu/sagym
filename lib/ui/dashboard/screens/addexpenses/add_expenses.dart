import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/constants/methods/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';

import '../../../../widgets/drop_down_text_field.dart';

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
  bool isAdded = false;
  final kCurrentUser = FirebaseAuth.instance.currentUser;
  String imagePath = "";
  String selectedAccessoriesType = "Dumbbells";

  Future getCurrentUser() async {
    if (kCurrentUser?.displayName == null || kCurrentUser?.displayName == "") {
      final snapshots = await _fireStore
          .collection("Trainers")
          .doc(kCurrentUser?.email)
          .get();
      setState(() {
        _gymAccessoriesAddedByController.text = snapshots.get("userName");
        imagePath = "";
      });
    } else {
      try {
        if (kCurrentUser != null) {
          _gymAccessoriesAddedByController.text = kCurrentUser!.displayName!;
          imagePath = kCurrentUser!.photoURL!;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _backgroundContainer(size),
              Container(
                padding: kAllSideBigPadding,
                margin: EdgeInsets.only(
                  top: size.height * 0.07,
                ),
                child: Container(
                  height: size.height * 0.85,
                  decoration: kCardBoxDecoration,
                  child: Padding(
                    padding: kAllSidePadding,
                    child: isAdded
                        ? customCircularIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kExpensesDetails,
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
            await _saveExpenseDetailToFirestore();
          },
          child: Padding(
            padding: kAllSideSmallPadding,
            child: Text(
              kAddExpense,
              style: kCustomButtonTextStyle,
            ),
          ),
        ),
      );

  TextFormFieldContainer _gymAccessoriesNameTextField() =>
      TextFormFieldContainer(
        label: kAccessoriesName,
        inputType: TextInputType.text,
        controller: _gymAccessoriesNameController,
        focusNode: _gymAccessoriesNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _gymAccessoriesNameFocusNode,
              _gymAccessoriesTypeFocusNode);
        },
      );

  DropDownTextField _gymAccessoriesTypeTextField() => DropDownTextField(
        list: accessoriesTypeList,
        value: selectedAccessoriesType,
        title: "Accessories Type",
        focusNode: _gymAccessoriesTypeFocusNode,
        onChanged: (newValue) {
          setState(() {
            selectedAccessoriesType = newValue.toString();
            _gymAccessoriesTypeController.text = newValue.toString();
          });
        },
      );

  TextFormFieldContainer _gymAccessoriesExpenseTextField() =>
      TextFormFieldContainer(
        label: kExpense,
        inputType: TextInputType.number,
        controller: _gymAccessoriesExpenseController,
        focusNode: _gymAccessoriesExpenseFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _gymAccessoriesExpenseFocusNode,
              _gymAccessoriesAddedByFocusNode);
        },
      );

  TextFormFieldContainer _gymAccessoriesAddedByTextField() =>
      TextFormFieldContainer(
        label: kAddedBy,
        inputType: TextInputType.text,
        controller: _gymAccessoriesAddedByController,
        focusNode: _gymAccessoriesAddedByFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(context, _gymAccessoriesAddedByFocusNode);
        },
      );

  Container _backgroundContainer(size) => Container(
        padding: kAllSideBigPadding,
        height: size.height * 0.2,
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
                  kAddExpense,
                  style: kAppBarTextStyle,
                ),
              ],
            ),
          ),
        ],
      );

  _saveExpenseDetailToFirestore() async {
    if (_gymAccessoriesNameController.text.trim().isNotEmpty &&
        _gymAccessoriesTypeController.text.trim().isNotEmpty &&
        _gymAccessoriesExpenseController.text.trim().isNotEmpty &&
        _gymAccessoriesAddedByController.text.trim().isNotEmpty) {
      setState(() {
        isAdded = true;
      });
      try {
        await _fireStore.collection("Expenses").add({
          'accessoriesName': _gymAccessoriesNameController.text,
          'accessoriesType': _gymAccessoriesTypeController.text,
          'accessoriesExpense': "${_gymAccessoriesExpenseController.text} ₹",
          'addedBy': _gymAccessoriesAddedByController.text,
          'userUid': kCurrentUser?.uid,
          'userProfileImage': imagePath.isEmpty ? kAvatarImagePath : imagePath,
        });
        setState(() {
          isAdded = false;
        });
        showMessage("Expense added successfully!");
        Navigator.pop(context);
        _gymAccessoriesNameController.clear();
        _gymAccessoriesTypeController.clear();
        _gymAccessoriesExpenseController.clear();
        _gymAccessoriesAddedByController.clear();
      } catch (e) {
        showMessage("Please enter correct details!");
      }
    } else {
      showMessage("Please enter correct details!");
    }
  }
}
