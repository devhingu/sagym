import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';

//strings
String kWelcome = "Welcome, ";
String kTotalMembers = "Total Members";
String kActive = "Active";
String kInactive = "Inactive";
String kReceived = "Received";
String kDue = "Due";
String kDueUsers = "Due Users";
String kPaymentDetails = "Payment Details";
String kPersonalDetails = "Personal Details";
String kMembershipDetails = "Membership Details";
String kAddNewMember = "Add New Member";
String kAddMember = "Add Member";
String kAddExpenses = "Add Expenses";
String kStepOne = "Step 1 of 2";
String kStepTwo = "Step 2 of 2";
String kFirstName = "First Name";
String kLastName = "Last Name";
String kMobileNumber = "Mobile Number";
String kAddress = "Address";
String kDOB = "DOB";
String kHeight = "Height";
String kWeight = "Weight";
String kBatch = "Batch (Optional)";
String kStaffName = "Staff Name";
String kPayment = "Payment";
String kPaymentType = "Payment Type";
String kAmount = "Amount";
String kMembershipPlan = "Membership Plan";

//icons
const kEllipsisIcon = CupertinoIcons.ellipsis_vertical;

//image paths
const kAvatarImagePath = "assets/avatar.png";

//text styles
const kAppBarTextStyle = TextStyle(
  color: kLightWhiteColor,
  fontSize: 18.0,
);

const kTitleTextStyle = TextStyle(
  color: kWhiteColor,
  fontSize: 25.0,
);

const kMemberCountTextStyle = TextStyle(
  color: kWhiteColor,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const kDateTextStyle = TextStyle(
  color: kLightWhiteColor,
  fontSize: 14.0,
);

const kCardTitleTextStyle = TextStyle(
  color: kMainColor,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
);

//box decoration
BoxDecoration kCardBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(5.0),
  boxShadow: [
    BoxShadow(
      offset: const Offset(0, 5),
      color: kBlackColor.withOpacity(0.2),
      blurRadius: 8.0,
    )
  ],
);
