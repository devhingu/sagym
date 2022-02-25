import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/dashboard/screens/add_member_payment_screen.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';
import 'package:gym/widgets/text_form_field_container.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
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
                          "Personal Details",
                          style: kTextFormFieldTextStyle,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: TextFormFieldContainer(
                                margin: EdgeInsets.only(top: 16.0),
                                label: "First Name",
                                obscureText: false,
                                inputType: TextInputType.text,
                              ),
                            ),
                            widthSizedBox(width: 10.0),
                            const Expanded(
                              child: TextFormFieldContainer(
                                margin: EdgeInsets.only(top: 16.0),
                                label: "Last Name",
                                obscureText: false,
                                inputType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Email",
                          obscureText: false,
                          inputType: TextInputType.emailAddress,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Mobile Number",
                          obscureText: false,
                          inputType: TextInputType.phone,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Address",
                          obscureText: false,
                          inputType: TextInputType.streetAddress,
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Mobile Number",
                          obscureText: false,
                          inputType: TextInputType.phone,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: TextFormFieldContainer(
                                margin: EdgeInsets.only(top: 16.0),
                                label: "DOB",
                                obscureText: false,
                                inputType: TextInputType.text,
                              ),
                            ),
                            widthSizedBox(width: 10.0),
                            const Expanded(
                              child: TextFormFieldContainer(
                                margin: EdgeInsets.only(top: 16.0),
                                label: "Height",
                                obscureText: false,
                                inputType: TextInputType.number,
                              ),
                            ),
                            widthSizedBox(width: 10.0),
                            const Expanded(
                              child: TextFormFieldContainer(
                                margin: EdgeInsets.only(top: 16.0),
                                label: "Weight",
                                obscureText: false,
                                inputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const TextFormFieldContainer(
                          margin: EdgeInsets.only(top: 16.0),
                          label: "Batch (Optional)",
                          obscureText: false,
                          inputType: TextInputType.text,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Step 1 of 2",
                                style: kTextFormFieldTextStyle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddMemberPaymentScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 45.0,
                                  width: 45.0,
                                  color: kMainColor,
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ),
                              )
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
            "Step 1 of 2",
            style: kAppBarTextStyle,
          ),
        ],
      );
}
