import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/box_decoration_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/icon_constants.dart';
import '../../../../constants/param_constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../constants/text_style_constants.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../utils/models/member_detail_model.dart';
import '../../../../utils/models/member_membership_model.dart';
import '../../../../widgets/text_form_field_container.dart';
import '../../../../provider/member_provider.dart';
import '../../../../widgets/drop_down_text_field.dart';
import '../../../../widgets/elevated_custom_button.dart';

class AddMemberPaymentScreen extends StatefulWidget {
  final MemberDetailModel model;
  static const String id = "add_member_payment_screen";

  const AddMemberPaymentScreen({Key? key, required this.model})
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
  final _formKey = GlobalKey<FormState>();

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
    _memberShipPlanController.text = selectedMemberShipPlan;
    _paymentTypeController.text = selectedPaymentType;
    _paymentController.text = selectedPaymentStatus;
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                          decoration: kCardBoxDecoration,
                          child: Padding(
                            padding: kAllSidePadding,
                            child: Form(
                              key: _formKey,
                              child: _memberShipDetailsColumn(context, size),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
              backgroundColor: kBackgroundColor,
              radius: 30.0,
              child: Icon(
                icCheck,
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
            onTap: () async {
              Navigator.pop(context);
            },
            child: Row(
              children: const [
                Icon(
                  icBackArrow,
                  color: kLightWhiteColor,
                ),
                Text(
                  kAddNewMember,
                  style: kAppBarTextStyle,
                ),
              ],
            ),
          ),
          const Text(
            kStepTwo,
            style: kAppBarTextStyle,
          ),
        ],
      );

  Column _memberShipDetailsColumn(BuildContext context, Size size) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            kMembershipDetails,
            style: kTextFormFieldTextStyle,
          ),
          _memberShipTextField(),
          _amountTextField(),
          _paymentTypeTextField(),
          _paymentTextField(),
          _staffNameTextField(),
          _bottomPreviousButton(context, size),
        ],
      );

  DropDownTextField _memberShipTextField() {
    return DropDownTextField(
      list: memberShipPlanList,
      value: selectedMemberShipPlan,
      focusNode: _memberShipPlanFocusNode,
      title: kMembershipPlan,
      onChanged: (newValue) {
        setState(() {
          _memberShipPlanController.text = newValue.toString();
        });
      },
    );
  }

  TextFormFieldContainer _amountTextField() => TextFormFieldContainer(
        label: kAmount,
        inputType: TextInputType.number,
        controller: _amountController,
        focusNode: _amountFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(
              context, _amountFocusNode, _staffNameFocusNode);
        },
        validator: (String? amount) {
          if (amount!.trim().isEmpty) {
            return 'Please enter $kAmount!';
          } else if (amount.length > 4) {
            return 'Please enter valid $kAmount!';
          }
          return null;
        },
      );

  DropDownTextField _paymentTypeTextField() {
    return DropDownTextField(
      list: paymentTypeList,
      value: selectedPaymentType,
      focusNode: _paymentTypeFocusNode,
      title: kPaymentType,
      onChanged: (newValue) {
        setState(() {
          _paymentTypeController.text = newValue.toString();
        });
      },
    );
  }

  DropDownTextField _paymentTextField() {
    return DropDownTextField(
      list: paymentStatusList,
      focusNode: _paymentFocusNode,
      title: kPayment,
      value: selectedPaymentStatus,
      onChanged: (newValue) {
        setState(() {
          _paymentController.text = newValue.toString();
        });
      },
    );
  }

  TextFormFieldContainer _staffNameTextField() => TextFormFieldContainer(
        label: kStaffName,
        inputType: TextInputType.text,
        controller: _staffNameController,
        focusNode: _staffNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(context, _staffNameFocusNode);
        },
      );

  Padding _bottomPreviousButton(BuildContext context, size) => Padding(
    padding: kTopPadding,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
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

  _saveMemberDetailsToFirestore() async {
    int amount = 5000;
    int dueAmount = 0;
    int enteredAmount = int.parse(_amountController.text);

    if (_formKey.currentState!.validate()) {
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

      MemberMembershipModel memberMembershipModel = MemberMembershipModel(
        memberShipPlan: _memberShipPlanController.text,
        dueAmount: dueAmount.toString(),
        receivedAmount: enteredAmount.toString(),
        paymentType: _paymentTypeController.text,
        paymentStatus: _paymentController.text,
        staffName: _staffNameController.text,
      );
      try {
        await _fireStore
            .collection("Trainers")
            .doc(kCurrentUser?.email)
            .collection("memberDetails")
            .doc(widget.model.email)
            .set({
          paramFirstName: widget.model.firstName,
          paramLastName: widget.model.lastName,
          paramEmail: widget.model.email,
          paramPhone: widget.model.phone,
          paramAddress: widget.model.address,
          paramDob: widget.model.dob,
          paramHeight: widget.model.height,
          paramWeight: widget.model.weight,
          paramBatch: widget.model.batch,
          paramStatus: widget.model.status,
          paramMemberShipPlan: memberMembershipModel.memberShipPlan,
          paramDueAmount: memberMembershipModel.dueAmount,
          paramReceivedAmount: memberMembershipModel.receivedAmount,
          paramPaymentType: memberMembershipModel.paymentType,
          paramPayment: memberMembershipModel.paymentStatus,
          paramStaffName: memberMembershipModel.staffName,
        });
        setState(() {
          isAdded = false;
        });
        await getCurrentData();
        Navigator.pop(context);
        Navigator.pop(context);
        _memberShipPlanController.clear();
        _amountController.clear();
        _paymentController.clear();
        _paymentTypeController.clear();
      } catch (e) {
        showMessage("Add member failed!");
      }
    }
  }
}
