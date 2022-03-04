import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

//strings
String kMemberEntries = "Member Entries";
String kBgImagePath = "assets/bgimage.jpg";
String kSearch = "Search";
String kEntryDetails = "Entry Details";

//firebase params
String paramsFirstName = "firstName";
String paramsLastName = "lastName";
String paramsEmail = "email";
String paramsPhone = "phone";
String paramsAddress = "address";
String paramsDob = "dob";
String paramsHeight = "height";
String paramsWeight = "weight";
String paramsBatch = "batch";
String paramsMemberShipPlan = "memberShipPlan";
String paramsPayment = "paymentStatus";
String paramsPaymentType = "paymentType";
String paramsReceivedAmount = "receivedAmount";
String paramsDueAmount = "dueAmount";
String paramsStaffName = "staffName";
String paramsUserName = "userName";
String paramsStatus = "status";


//icons
const kActiveCircleIcon = Icons.album_outlined;
const kSearchIcon = Icons.search;
const kPhoneIcon = Icons.phone;
const kMailIcon = Icons.mail;
const kCheckIcon =  Icons.check;

//box decoration
BoxDecoration kMemberDetailBoxDecoration = BoxDecoration(
  borderRadius: const BorderRadius.only(
    topRight: Radius.circular(25.0),
    topLeft: Radius.circular(25.0),
  ),
  boxShadow: [
    BoxShadow(
      color: kWhiteColor.withOpacity(0.2),
      offset: const Offset(0, -6),
      blurRadius: 8.0,
    ),
  ],
  color: Colors.white,
);

//text styles
const kMemberTileNameTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kMemberDetailNameTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const kMemberTileTextStyle = TextStyle(
  fontSize: 16.0,
  color: kDarkGreyColor,
);

const kMemberAddedTextStyle = TextStyle(
  color: kWhiteColor,
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);
