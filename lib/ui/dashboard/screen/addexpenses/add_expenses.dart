import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/icon_constants.dart';
import '../../../../constants/asset_constants.dart';
import '../../../../constants/box_decoration_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/param_constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../constants/text_style_constants.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../utils/models/expenses_model.dart';
import '../../../../widgets/add_success_container.dart';
import '../../../../widgets/drop_down_text_field.dart';
import '../../../../widgets/elevated_custom_button.dart';
import '../../../../widgets/text_form_field_container.dart';

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

  String selectedAccessoriesAddedBy = "";
  List<String> addedByList = [];
  final _formKey = GlobalKey<FormState>();

  Future getCurrentUser() async {
    if (kCurrentUser?.displayName == null || kCurrentUser?.displayName == "") {
      final snapshots = await _fireStore
          .collection("Trainers")
          .doc(kCurrentUser?.email)
          .get();
      setState(() {
        _gymAccessoriesAddedByController.text = snapshots.get("userName");
        selectedAccessoriesAddedBy = snapshots.get("userName");
        imagePath = "";
      });
    } else {
      try {
        if (kCurrentUser != null) {
          _gymAccessoriesAddedByController.text = kCurrentUser!.displayName!;
          selectedAccessoriesAddedBy = kCurrentUser!.displayName!;
          imagePath = kCurrentUser!.photoURL!;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  getMemberListData() async {
    var data = _fireStore.collection("Trainers").snapshots();

    data.forEach((element) {
      for (var member in element.docs) {
        addedByList.add(member["userName"]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _gymAccessoriesTypeController.text = selectedAccessoriesType;
    getMemberListData();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isAdded
            ? const AddSuccessContainer(
                message: "Expense Added Successfully!",
              )
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    _backgroundContainer(size),
                    Container(
                      padding: kAllSideBigPadding,
                      margin: EdgeInsets.only(
                        top: size.height * 0.07,
                      ),
                      child: Container(
                        decoration: kCardBoxDecoration,
                        child: Padding(
                          padding: kAllSidePadding,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  kExpensesDetails,
                                  style: kTextFormFieldTextStyle,
                                ),
                                _gymAccessoriesNameTextField(),
                                _gymAccessoriesTypeTextField(),
                                _gymAccessoriesExpenseTextField(),
                                _gymAccessoriesAddedByTextField(),
                                _bottomButton(context),
                              ],
                            ),
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
              children: const [
                Icon(
                  icBackArrow,
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

  TextFormFieldContainer _gymAccessoriesNameTextField() =>
      TextFormFieldContainer(
        label: kAccessoriesName,
        inputType: TextInputType.text,
        controller: _gymAccessoriesNameController,
        focusNode: _gymAccessoriesNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _gymAccessoriesNameFocusNode,
              _gymAccessoriesExpenseFocusNode);
        },
        validator: (value) {
          if (value!.trim().isEmpty) {
            return 'Please enter $kAccessoriesName!';
          } else if (value.length < 3) {
            return '$kAccessoriesName should be at least 3 characters!';
          }
          return null;
        },
      );

  DropDownTextField _gymAccessoriesTypeTextField() => DropDownTextField(
        list: accessoriesTypeList,
        value: selectedAccessoriesType,
        title: kAccessoriesType,
        focusNode: _gymAccessoriesTypeFocusNode,
        onChanged: (newValue) {
          setState(() {
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
          onSubmittedUnFocusMethod(context, _gymAccessoriesExpenseFocusNode);
        },
        validator: (value) {
          if (value!.trim().isEmpty) {
            return 'Please enter $kExpense!';
          } else if (value.length < 3) {
            return '$kExpense should be at least 3 digits!';
          }
          return null;
        },
      );

  DropDownTextField _gymAccessoriesAddedByTextField() => DropDownTextField(
        list: addedByList,
        value: selectedAccessoriesAddedBy,
        title: kAddedBy,
        focusNode: _gymAccessoriesAddedByFocusNode,
        onChanged: (newValue) {
          setState(() {
            _gymAccessoriesAddedByController.text = newValue.toString();
          });
        },
      );

  Padding _bottomButton(BuildContext context) => Padding(
        padding: kTopPadding,
        child: Align(
          alignment: Alignment.center,
          child: ElevatedCustomButton(
            title: kAddExpense,
            onPress: () async {
              await _saveExpenseDetailToFirestore();
            },
          ),
        ),
      );

  _saveExpenseDetailToFirestore() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isAdded = true;
      });
      ExpenseModel expenseModel = ExpenseModel(
        accessoriesName: _gymAccessoriesNameController.text,
        accessoriesType: _gymAccessoriesTypeController.text,
        accessoriesExpense: "${_gymAccessoriesExpenseController.text} ₹",
        addedBy: _gymAccessoriesAddedByController.text,
        userUid: kCurrentUser!.uid,
        userProfileImage: imagePath.isEmpty ? kAvatarImagePath : imagePath,
      );

      try {
        await _fireStore.collection("Expenses").add({
          paramAccessoriesName: expenseModel.accessoriesName,
          paramAccessoriesType: expenseModel.accessoriesType,
          paramAccessoriesExpense: expenseModel.accessoriesExpense,
          paramAddedBy: expenseModel.addedBy,
          paramUserUid: expenseModel.userUid,
          paramUserProfileImage: expenseModel.userProfileImage,
        });
        setState(() {
          isAdded = false;
        });
        Navigator.pop(context);
        _gymAccessoriesNameController.clear();
        _gymAccessoriesTypeController.clear();
        _gymAccessoriesExpenseController.clear();
        _gymAccessoriesAddedByController.clear();
      } catch (e) {
        showMessage("Expense not added!");
      }
    }
  }
}
