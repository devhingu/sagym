import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/add_member_screen.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';

class AddMemberPaymentScreen extends StatefulWidget {
  const AddMemberPaymentScreen({Key? key}) : super(key: key);

  @override
  _AddMemberPaymentScreenState createState() => _AddMemberPaymentScreenState();
}

class _AddMemberPaymentScreenState extends State<AddMemberPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              backgroundContainer(),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Container(
                  decoration: kCardBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Membership Details",
                          style: kTextFormFieldTextStyle,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Membership Plan",
                          obscureText: false,
                          inputType: TextInputType.text,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Amount",
                          obscureText: false,
                          inputType: TextInputType.text,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Payment Type",
                          obscureText: false,
                          inputType: TextInputType.text,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Payment",
                          obscureText: false,
                          inputType: TextInputType.text,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Staff Name",
                          obscureText: false,
                          inputType: TextInputType.text,
                        ),
                        heightSizedBox(height: 140.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Step 2 of 2",
                                style: kTextFormFieldTextStyle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddMemberScreen(),),);
                                },
                                child: Container(
                                  height: 45.0,
                                  width: 45.0,
                                  color: kMainColor,
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
                                  color: kFloatingActionButtonColor,
                                  child: const Center(
                                    child: Text("Add Member", style: kCustomButtonTextStyle,)
                                  ),
                                ),
                              ),
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

  Container backgroundContainer() => Container(
        padding: const EdgeInsets.all(16.0),
        height: 185,
        color: kMainColor,
        child: homeCustomAppBar(),
      );

  Row homeCustomAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.arrow_back_ios,
                color: kLightWhiteColor,
              ),
              Text(
                "Add New Member",
                style: kAppBarTextStyle,
              ),
            ],
          ),
          const Text(
            "Step 2 of 2",
            style: kAppBarTextStyle,
          ),
        ],
      );
}
