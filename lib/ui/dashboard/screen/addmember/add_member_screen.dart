import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screen/addmember/add_member_payment_screen.dart';
import 'package:gym/ui/member/constants/member_constants.dart';
import 'package:gym/widgets/drop_down_text_field.dart';
import 'package:gym/constants/methods/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';

class AddMemberScreen extends StatefulWidget {
  static const String id = "add_member_screen";

  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();
  final FocusNode _weightFocusNode = FocusNode();
  final FocusNode _batchFocusNode = FocusNode();
  String _isActive = "true";
  String selectedBatch = "Morning";
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.value = TextEditingValue(
            text: "${picked.day}-${picked.month}-${picked.year}");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    _dobFocusNode.dispose();
    _heightFocusNode.dispose();
    _weightFocusNode.dispose();
    _batchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _backgroundContainer(),
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
                    child: _personalDetailsColumn(context, size),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _personalDetailsColumn(BuildContext context, Size size) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kPersonalDetails,
            style: kTextFormFieldTextStyle,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _firstNameTextField(),
                ),
                widthSizedBox(width: 10.0),
                Expanded(
                  child: _lastNameTextField(),
                ),
              ],
            ),
          ),
          Expanded(child: _emailTextField()),
          Expanded(
            child: _mobileNumberTextField(),
          ),
          Expanded(
            child: _addressTextField(),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _dobTextField(),
                ),
                widthSizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: _heightTextField(),
                ),
                widthSizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: _weightTextField(),
                ),
              ],
            ),
          ),
          Expanded(
            child: _batchTextField(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _activeRadioTile(),
              ),
              Expanded(
                child: _inactiveRadioTile(),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: _bottomNextButton(context, size)),
        ],
      );

  Row _inactiveRadioTile() => Row(
        children: [
          Radio<String>(
            value: 'inactive',
            groupValue: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value!;
              });
            },
          ),
          const Text('InActive'),
        ],
      );

  Row _activeRadioTile() => Row(
        children: [
          Radio<String>(
            value: 'active',
            groupValue: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value!;
              });
            },
          ),
          const Text('Active'),
        ],
      );

  GestureDetector _bottomNextButton(BuildContext context, size) =>
      GestureDetector(
        onTap: _saveMemberDetailsToFirestore,
        child: Container(
          height: size.height * 0.06,
          width: size.height * 0.06,
          decoration: kCustomButtonBoxDecoration,
          child: const Center(
            child: Icon(
              Icons.arrow_forward_ios,
              color: kWhiteColor,
            ),
          ),
        ),
      );

  DropDownTextField _batchTextField() => DropDownTextField(
        list: batchList,
        value: selectedBatch,
        onChanged: (newValue) {
          setState(() {
            selectedBatch = newValue.toString();
            _batchController.text = newValue.toString();
          });
        },
        title: kBatch,
        focusNode: _batchFocusNode,
      );

  TextFormFieldContainer _weightTextField() => TextFormFieldContainer(
        label: kWeight,
        inputType: TextInputType.number,
        controller: _weightController,
        focusNode: _weightFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _weightFocusNode, _batchFocusNode);
        },
      );

  TextFormFieldContainer _heightTextField() => TextFormFieldContainer(
        label: kHeight,
        inputType: TextInputType.number,
        controller: _heightController,
        focusNode: _heightFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _heightFocusNode, _weightFocusNode);
        },
      );

  GestureDetector _dobTextField() => GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormFieldContainer(
              label: kDOB,
              inputType: TextInputType.text,
              controller: _dobController,
              focusNode: _dobFocusNode,
              onSubmit: (String? value) {}),
        ),
      );

  TextFormFieldContainer _addressTextField() => TextFormFieldContainer(
        label: kAddress,
        inputType: TextInputType.streetAddress,
        controller: _addressController,
        focusNode: _addressFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _addressFocusNode, _heightFocusNode);
        },
      );

  TextFormFieldContainer _mobileNumberTextField() => TextFormFieldContainer(
        label: kMobileNumber,
        inputType: TextInputType.phone,
        controller: _phoneController,
        focusNode: _phoneFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _phoneFocusNode, _addressFocusNode);
        },
      );

  TextFormFieldContainer _emailTextField() => TextFormFieldContainer(
        label: kEmail,
        inputType: TextInputType.emailAddress,
        controller: _emailController,
        focusNode: _emailFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _emailFocusNode, _phoneFocusNode);
        },
      );

  TextFormFieldContainer _lastNameTextField() => TextFormFieldContainer(
        label: kLastName,
        inputType: TextInputType.text,
        controller: _lastNameController,
        focusNode: _lastNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _lastNameFocusNode, _emailFocusNode);
        },
      );

  TextFormFieldContainer _firstNameTextField() => TextFormFieldContainer(
        label: kFirstName,
        inputType: TextInputType.text,
        controller: _firstNameController,
        focusNode: _firstNameFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(
              context, _firstNameFocusNode, _lastNameFocusNode);
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
            kStepOne,
            style: kAppBarTextStyle,
          ),
        ],
      );

  _saveMemberDetailsToFirestore() async {
    final kCurrentUser = FirebaseAuth.instance.currentUser;
    final _fireStore = FirebaseFirestore.instance;

    if (_firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _addressController.text.trim().isNotEmpty &&
        _dobController.text.trim().isNotEmpty &&
        _heightController.text.trim().isNotEmpty &&
        _weightController.text.trim().isNotEmpty &&
        _batchController.text.trim().isNotEmpty) {
      try {
        await _fireStore
            .collection("Trainers")
            .doc(kCurrentUser?.email)
            .collection("memberDetails")
            .doc(_emailController.text)
            .set({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'dob': _dobController.text,
          'height': "${_heightController.text}cm",
          'weight': "${_weightController.text}kg",
          'batch': selectedBatch,
          'status': _isActive == "active" ? true : false
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddMemberPaymentScreen(email: _emailController.text),
          ),
        );
        _firstNameController.clear();
        _lastNameController.clear();
        _phoneController.clear();
        _addressController.clear();
        _dobController.clear();
        _heightController.clear();
        _weightController.clear();
        _batchController.clear();
      } catch (e) {
        showMessage("Please enter correct details!");
      }
    } else {
      showMessage("Please Enter Details!");
    }
  }
}
