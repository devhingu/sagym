import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/add_member_screen.dart';
import 'package:gym/ui/dashboard/screens/home_screen.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';

class AddMemberPaymentScreen extends StatefulWidget {
  static const String id = "add_member_payment_screen";

  const AddMemberPaymentScreen({Key? key}) : super(key: key);

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
                          kMembershipDetails,
                          style: kTextFormFieldTextStyle,
                        ),
                        _membershipPlanTextField(),
                        _amountTextField(),
                        _paymentTypeTextField(),
                        _paymentTextField(),
                        _staffNameTextField(),
                        heightSizedBox(height: 71.0),
                        _bottomPreviousButton(context),
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
                navigatePushNamedMethod(context, AddMemberScreen.id);
              },
              child: Container(
                height: 45.0,
                width: 45.0,
                decoration: kCustomButtonBoxDecoration,
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 45.0,
                width: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: kFloatingActionButtonColor,
                ),
                child: Center(
                  child: Text(
                    kAddMember,
                    style: kCustomButtonTextStyle,
                  ),
                ),
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
              navigatePushReplacementMethod(context, AddMemberScreen.id);
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
}
