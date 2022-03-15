import 'package:flutter/material.dart';
import '../../../../constants/box_decoration_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../constants/text_style_constants.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../../utils/models/member_detail_model.dart';
import '../../../../widgets/drop_down_text_field.dart';
import '../../../../widgets/text_form_field_container.dart';
import 'add_member_payment_screen.dart';

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
  final _formKey = GlobalKey<FormState>();

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
  void initState() {
    super.initState();
    _batchController.text = selectedBatch;
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
                      child: _personalDetailsColumn(context, size),
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
          const Text(
            kStepOne,
            style: kAppBarTextStyle,
          ),
        ],
      );

  Column _personalDetailsColumn(BuildContext context, Size size) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            kPersonalDetails,
            style: kTextFormFieldTextStyle,
          ),
          Row(
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
          _emailTextField(),
          _mobileNumberTextField(),
          _addressTextField(),
          Row(
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
          _batchTextField(),
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
            child: _bottomNextButton(context, size),
          ),
        ],
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
        validator: (String? firstName) {
          if (firstName!.trim().isEmpty) {
            return 'Please enter $kFirstName!';
          }
          return null;
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
        validator: (String? lastName) {
          if (lastName!.trim().isEmpty) {
            return 'Please enter $kLastName!';
          }
          return null;
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
        validator: validateEmail,
      );

  TextFormFieldContainer _mobileNumberTextField() => TextFormFieldContainer(
        label: kMobileNumber,
        inputType: TextInputType.phone,
        controller: _phoneController,
        focusNode: _phoneFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _phoneFocusNode, _addressFocusNode);
        },
        validator: validateMobile,
      );

  TextFormFieldContainer _addressTextField() => TextFormFieldContainer(
        label: kAddress,
        inputType: TextInputType.streetAddress,
        controller: _addressController,
        focusNode: _addressFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _addressFocusNode, _heightFocusNode);
        },
        validator: (String? address) {
          if (address!.trim().isEmpty) {
            return 'Please enter $kAddress!';
          }
          return null;
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
            onSubmit: (String? value) {},
            validator: (String? dob) {
              if (dob!.trim().isEmpty) {
                return 'Please select Date of Birth!';
              }
              return null;
            },
          ),
        ),
      );

  TextFormFieldContainer _heightTextField() => TextFormFieldContainer(
        label: kHeight,
        inputType: TextInputType.number,
        controller: _heightController,
        focusNode: _heightFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _heightFocusNode, _weightFocusNode);
        },
        validator: (String? height) {
          if (height!.trim().isEmpty) {
            return 'Please enter $kHeight!';
          } else if (height.length > 3) {
            return 'Please enter valid $kHeight!!';
          }
          return null;
        },
      );

  TextFormFieldContainer _weightTextField() => TextFormFieldContainer(
        label: kWeight,
        inputType: TextInputType.number,
        controller: _weightController,
        focusNode: _weightFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(context, _weightFocusNode);
        },
        validator: (String? weight) {
          if (weight!.trim().isEmpty) {
            return 'Please enter $kWeight!';
          } else if (weight.length > 3) {
            return 'Please enter valid $kWeight!';
          }
          return null;
        },
      );

  DropDownTextField _batchTextField() => DropDownTextField(
        list: batchList,
        value: selectedBatch,
        onChanged: (newValue) {
          setState(() {
            _batchController.text = newValue.toString();
          });
        },
        title: kBatch,
        focusNode: _batchFocusNode,
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

  _saveMemberDetailsToFirestore() async {
    if (_formKey.currentState!.validate()) {
      try {
        MemberDetailModel memberDetailModel = MemberDetailModel(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          dob: _dobController.text,
          height: "${_heightController.text}cm",
          weight: "${_weightController.text}kg",
          batch: _batchController.text,
          status: _isActive == "active" ? true : false,
        );

        await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                AddMemberPaymentScreen(model: memberDetailModel),
          ),
        );
      } catch (e) {
        showMessage("Please enter valid details!");
      }
    }
  }
}
