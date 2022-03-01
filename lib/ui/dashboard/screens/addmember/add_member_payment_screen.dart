import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/addmember/add_member_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/ui/member/screens/member_list.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';

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
  String userName = "";

  Future getCurrentUser() async {
    if (kCurrentUser?.displayName == null || kCurrentUser?.displayName == "") {
      final snapshots = await _fireStore
          .collection("Trainers")
          .doc(kCurrentUser?.email)
          .collection("trainerDetails")
          .get();
      setState(() {
        _staffNameController.text = snapshots.docs.first.get("userName");
      });
    } else {
      try {
        if (kCurrentUser != null) {
          _staffNameController.text = kCurrentUser!.displayName!;
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
    _memberShipPlanFocusNode.dispose();
    _amountFocusNode.dispose();
    _paymentFocusNode.dispose();
    _paymentTypeFocusNode.dispose();
    _staffNameFocusNode.dispose();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kMembershipDetails,
                          style: kTextFormFieldTextStyle,
                        ),
                        Expanded(child: _membershipPlanTextField()),
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
                        Expanded(
                          child: _bottomPreviousButton(context),
                        ),
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

  Padding _bottomPreviousButton(BuildContext context) => Padding(
        padding: kTopPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kStepTwo,
              style: kTextFormFieldTextStyle,
            ),
            GestureDetector(
              onTap: () {
                navigatePushReplacementMethod(context, AddMemberScreen.id);
              },
              child: Container(
                height: 35.0,
                width: 35.0,
                decoration: kCustomButtonBoxDecoration,
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(kFloatingActionButtonColor),
              ),
              onPressed: () async {
                await _saveMemberDetailsToFirestore();
                Navigator.pop(context);
              },
              child: Text(
                kAddMember,
                style: kCustomButtonTextStyle,
              ),
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

  TextFormFieldContainer _paymentTextField() => TextFormFieldContainer(
        label: kPayment,
        inputType: TextInputType.text,
        controller: _paymentController,
        focusNode: _paymentTypeFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(
              context, _paymentTypeFocusNode, _staffNameFocusNode);
        },
      );

  TextFormFieldContainer _paymentTypeTextField() => TextFormFieldContainer(
        label: kPaymentType,
        inputType: TextInputType.text,
        controller: _paymentTypeController,
        focusNode: _paymentFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(
              context, _paymentFocusNode, _paymentTypeFocusNode);
        },
      );

  TextFormFieldContainer _amountTextField() => TextFormFieldContainer(
        label: kAmount,
        inputType: TextInputType.text,
        controller: _amountController,
        focusNode: _amountFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _amountFocusNode, _paymentFocusNode);
        },
      );

  TextFormFieldContainer _membershipPlanTextField() => TextFormFieldContainer(
        label: kMembershipPlan,
        inputType: TextInputType.text,
        controller: _memberShipPlanController,
        focusNode: _memberShipPlanFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(
              context, _memberShipPlanFocusNode, _amountFocusNode);
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
  }
}
