import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/add_member_payment_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/ui/dashboard/screens/home_screen.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
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

  @override
  void dispose() {
    super.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    _dobFocusNode.dispose();
    _heightFocusNode.dispose();
    _weightFocusNode.dispose();
    _batchFocusNode.dispose();
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
                margin: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Container(
                  decoration: kCardBoxDecoration,
                  child: Padding(
                    padding: kAllSidePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
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
                        Padding(
                          padding: kTopPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kStepOne,
                                style: kTextFormFieldTextStyle,
                              ),
                              _bottomNextButton(context)
                            ],
                          ),
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

  GestureDetector _bottomNextButton(BuildContext context) => GestureDetector(
        onTap: () {
          navigatePushNamedMethod(context, AddMemberPaymentScreen.id);
        },
        child: Container(
          height: 45.0,
          width: 45.0,
          decoration: kCustomButtonBoxDecoration,
          child: const Center(
            child: Icon(
              Icons.arrow_forward_ios,
              color: kWhiteColor,
            ),
          ),
        ),
      );

  TextFormFieldContainer _batchTextField() => TextFormFieldContainer(
        label: kBatch,
        inputType: TextInputType.text,
        controller: _batchController,
        focusNode: _batchFocusNode,
        onSubmit: (String? value) {
          onSubmittedUnFocusMethod(context, _batchFocusNode);
        },
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

  TextFormFieldContainer _dobTextField() => TextFormFieldContainer(
      label: kDOB,
      inputType: TextInputType.text,
      controller: _dobController,
      focusNode: _dobFocusNode,
      onSubmit: (String? value) {
        onSubmittedFocusMethod(context, _dobFocusNode, _heightFocusNode);
      });

  TextFormFieldContainer _addressTextField() => TextFormFieldContainer(
        label: kAddress,
        inputType: TextInputType.streetAddress,
        controller: _addressController,
        focusNode: _addressFocusNode,
        onSubmit: (String? value) {
          onSubmittedFocusMethod(context, _addressFocusNode, _dobFocusNode);
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
        height: 185,
        color: kMainColor,
        child: _homeCustomAppBar(),
      );

  Row _homeCustomAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //navigatePushReplacementMethod(context, HomePage.id);
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
}
