import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/addmember/add_member_screen.dart';
import 'package:gym/ui/dashboard/screens/bottom_sheet_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/ui/member/screens/member_list.dart';
import 'package:gym/constants/methods/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/member_provider.dart';
import '../../../../widgets/drop_down_text_field.dart';
import '../../../../widgets/elevated_custom_button.dart';
import '../../../member/constants/member_constants.dart';

class AddMemberPaymentScreen extends StatefulWidget {
  final String email;
  static const String id = "add_member_payment_screen";

  const AddMemberPaymentScreen({Key? key, required this.email})
      : super(key: key);

  @override
  _AddMemberPaymentScreenState createState() => _AddMemberPaymentScreenState();
}

class _AddMemberPaymentScreenState extends State<AddMemberPaymentScreen> {
  final TextEditingController _memberShipPlanController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _staffNameController = TextEditingController();
  final FocusNode _memberShipPlanFocusNode = FocusNode();
  final FocusNode _paymentFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _paymentTypeFocusNode = FocusNode();
  final FocusNode _staffNameFocusNode = FocusNode();
  final _fireStore = FirebaseFirestore.instance;
  final kCurrentUser = FirebaseAuth.instance.currentUser;
  String selectedMemberShipPlan = "3 Months";
  String selectedPaymentStatus = "Success";
  String selectedPaymentType = "Cash";
  bool isAdded = false;

  Future getCurrentUser() async {
    if (kCurrentUser?.displayName == null || kCurrentUser?.displayName == "") {
      final snapshots = await _fireStore
          .collection("Trainers")
          .doc(kCurrentUser?.email)
          .get();
      setState(() {
        _staffNameController.text = snapshots.get("userName");
      });
    } else {
      try {
        if (kCurrentUser != null) {
          _staffNameController.text = kCurrentUser!.displayName!;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future getCurrentData() async {
    var snapshot = _fireStore
        .collection("Trainers")
        .doc(kCurrentUser?.email)
        .collection("memberDetails")
        .snapshots();

    snapshot.forEach((element) {
      Provider.of<MemberData>(context, listen: false)
          .updateAmount(element.docs);
      Provider.of<MemberData>(context, listen: false)
          .updateUserStatus(element.docs);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    _memberShipPlanFocusNode.dispose();
    _amountFocusNode.dispose();
    _paymentFocusNode.dispose();
    _paymentTypeFocusNode.dispose();
    _staffNameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isAdded
            ? _successContainer(size)
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
                        height: size.height * 0.85,
                        decoration: kCardBoxDecoration,
                        child: Padding(
                          padding: kAllSidePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kMembershipDetails,
                                style: kTextFormFieldTextStyle,
                              ),
                              Expanded(
                                child: _memberShipTextField(),
                              ),
                              Expanded(
                                child: _amountTextField(),
                              ),
                              Expanded(
                                child: _paymentTypeTextField(),
                              ),
                              Expanded(
                                child: _paymentTextField(),
                              ),
                              Expanded(
                                child: _staffNameTextField(),
                              ),
                              // heightSizedBox(height: MediaQuery.of(context).size.height * 0.15),
                              _bottomPreviousButton(context, size),
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

  Container _successContainer(Size size) {
    return Container(
      color: kMainColor,
      height: size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.0,
              child: Icon(
                kCheckIcon,
                color: kGreenColor,
                size: 35.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Member Added Successfully!",
                textAlign: TextAlign.center,
                style: kMemberAddedTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _bottomPreviousButton(BuildContext context, size) => Padding(
        padding: kTopPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                navigatePushReplacementMethod(context, AddMemberScreen.id);
              },
              child: Container(
                height: size.height * 0.06,
                width: size.height * 0.06,
                decoration: kCustomButtonBoxDecoration,
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
            ElevatedCustomButton(
              onPress: _saveMemberDetailsToFirestore,
              title: kAddMember,
            ),
          ],
        ),
      );

  TextFormFieldContainer _staffNameTextField() => TextFormFieldContainer(
        label: kStaffName,
        inputType: TextInputType.text,
        controller: _staffNameController,
        focusNode: _staffNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(context, _staffNameFocusNode);
        },
      );

  TextFormFieldContainer _amountTextField() => TextFormFieldContainer(
        label: kAmount,
        inputType: TextInputType.number,
        controller: _amountController,
        focusNode: _amountFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _amountFocusNode, _paymentFocusNode);
        },
      );

  DropDownTextField _paymentTextField() {
    return DropDownTextField(
      list: paymentStatusList,
      focusNode: _paymentFocusNode,
      title: kPayment,
      value: selectedPaymentStatus,
      onChanged: (newValue) {
        setState(() {
          selectedPaymentStatus = newValue.toString();
          _paymentController.text = newValue.toString();
        });
      },
    );
  }

  DropDownTextField _paymentTypeTextField() {
    return DropDownTextField(
      list: paymentTypeList,
      value: selectedPaymentType,
      focusNode: _paymentTypeFocusNode,
      title: kPaymentType,
      onChanged: (newValue) {
        setState(() {
          selectedPaymentType = newValue.toString();
          _paymentTypeController.text = newValue.toString();
        });
      },
    );
  }

  DropDownTextField _memberShipTextField() {
    return DropDownTextField(
      list: memberShipPlanList,
      value: selectedMemberShipPlan,
      focusNode: _memberShipPlanFocusNode,
      title: kMembershipPlan,
      onChanged: (newValue) {
        setState(() {
          selectedMemberShipPlan = newValue.toString();
          _memberShipPlanController.text = newValue.toString();
        });
      },
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
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: kLightWhiteColor,
                ),
                Text(
                  kAddNewMember,
                  style: kAppBarTextStyle,
                ),
              ],
            ),
          ),
          Text(
            kStepTwo,
            style: kAppBarTextStyle,
          ),
        ],
      );

  _saveMemberDetailsToFirestore() async {
    int amount = 5000;
    int dueAmount = 0;
    int enteredAmount = int.parse(_amountController.text);

    if (_memberShipPlanController.text.trim().isNotEmpty &&
        _amountController.text.trim().isNotEmpty &&
        _paymentController.text.trim().isNotEmpty &&
        _paymentTypeController.text.trim().isNotEmpty) {
      if (enteredAmount < amount) {
        dueAmount = amount - enteredAmount;
      } else if (enteredAmount > 5000) {
        dueAmount = 0;
        enteredAmount = 5000;
      } else {
        dueAmount = 0;
      }
      setState(() {
        isAdded = true;
      });
      try {
        await _fireStore
            .collection("Trainers")
            .doc(kCurrentUser?.email)
            .collection("memberDetails")
            .doc(widget.email)
            .update({
          'memberShipPlan': _memberShipPlanController.text,
          'dueAmount': dueAmount.toString(),
          'receivedAmount': enteredAmount.toString(),
          'paymentType': _paymentTypeController.text,
          'paymentStatus': _paymentController.text,
          'staffName': _staffNameController.text,
        });
        setState(() {
          isAdded = false;
        });
        await getCurrentData();
        Navigator.pop(context);
        _memberShipPlanController.clear();
        _amountController.clear();
        _paymentController.clear();
        _paymentTypeController.clear();
      } catch (e) {
        showMessage("Please enter correct details!");
      }
    } else {
      showMessage("Please Enter Details!");
    }
  }
}
