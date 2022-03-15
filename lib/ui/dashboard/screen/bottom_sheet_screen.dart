import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/box_decoration_constants.dart';
import '../../../constants/constants.dart';
import '../../../constants/param_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../constants/text_style_constants.dart';
import '../../../utils/methods/reusable_methods.dart';
import '../../../widgets/elevated_custom_button.dart';
import '../../../widgets/text_form_field_container.dart';
import 'addexpenses/add_expenses.dart';
import 'addmember/add_member_screen.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({Key? key}) : super(key: key);

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final FocusNode _startDateFocusNode = FocusNode();
  final FocusNode _endDateFocusNode = FocusNode();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  bool isAdded = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(bottom: 100.0),
      height: size.height * 1.0,
      decoration: const BoxDecoration(
        color: Colors.black54,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _bottomSheetCard(
            title: kSendReminder,
            onPress: _sendReminderBottomSheet,
          ),
          heightSizedBox(height: 20.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bottomSheetCard(
                title: kAddMember,
                onPress: () {
                  navigatePopAndPushNamedMethod(context, AddMemberScreen.id);
                },
              ),
              _bottomSheetCard(
                title: kAddExpense,
                onPress: () {
                  navigatePopAndPushNamedMethod(context, AddExpensesScreen.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector _bottomSheetCard(
          {required VoidCallback onPress, required String title}) =>
      GestureDetector(
        onTap: onPress,
        child: Container(
          height: 100.0,
          width: 140.0,
          decoration: kCardBoxDecoration,
          child: Center(
            child: Text(
              title,
              style: kTextStyle,
            ),
          ),
        ),
      );

  Widget _bottomCardDataColumn(BuildContext context) => SingleChildScrollView(
        child: isAdded
            ? customCircularIndicator()
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          kSendReminder,
                          style: kAppTitleTextStyle,
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    _startDateTextField(),
                    _endDateTextField(),
                    heightSizedBox(height: 10.0),
                    _messageTextField(),
                    heightSizedBox(height: 10.0),
                    ElevatedCustomButton(
                      onPress: () async {
                        await _saveReminderDataToFirebase();
                      },
                      title: kSendReminder,
                    ),
                  ],
                ),
              ),
      );

  GestureDetector _startDateTextField() => GestureDetector(
        onTap: () => _selectStartDate(context),
        child: AbsorbPointer(
          child: TextFormFieldContainer(
            label: kStartDate,
            inputType: TextInputType.text,
            controller: _startDateController,
            focusNode: _startDateFocusNode,
            onSubmit: (String? value) {},
            validator: (String? startDate) {
              if (startDate!.trim().isEmpty) {
                return 'Please select $kStartDate!';
              }
              return null;
            },
          ),
        ),
      );

  GestureDetector _endDateTextField() => GestureDetector(
        onTap: () => _selectedEndDate(context),
        child: AbsorbPointer(
          child: TextFormFieldContainer(
            label: kEndDate,
            inputType: TextInputType.text,
            controller: _endDateController,
            focusNode: _endDateFocusNode,
            onSubmit: (String? value) {},
            validator: (String? endDate) {
              if (endDate!.trim().isEmpty) {
                return 'Please select $kEndDate!';
              }
              return null;
            },
          ),
        ),
      );

  TextFormField _messageTextField() => TextFormField(
        controller: _messageController,
        maxLines: 6,
        style: kTextFormFieldTextStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          border: textFormFieldInputBorder(),
          hintText: kMessage,
          labelStyle: kTextFormFieldLabelTextStyle,
          focusedBorder: textFormFieldInputBorder(),
        ),
        validator: (String? message) {
          if (message!.trim().isEmpty) {
            return 'Please enter description of reminder!';
          }
          return null;
        },
      );

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        _startDateController.value = TextEditingValue(
            text: "${picked.day}-${picked.month}-${picked.year}");
      });
    }
  }

  Future<void> _selectedEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        _endDateController.value = TextEditingValue(
            text: "${picked.day}-${picked.month}-${picked.year}");
      });
    }
  }

  _sendReminderBottomSheet() {
    showModalBottomSheet(
      context: context,
      elevation: 15.0,
      isScrollControlled: true,
      barrierColor: Colors.black.withAlpha(1),
      builder: (context) => Container(
        margin: kAllSideBigPadding,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: _bottomCardDataColumn(context),
      ),
    );
  }

  _saveReminderDataToFirebase() async {
    final kCurrentUser = FirebaseAuth.instance.currentUser;
    final _fireStore = FirebaseFirestore.instance;
    String currentDate = DateFormat.yMEd().add_jm().format(DateTime.now());

    if (_formKey.currentState!.validate()) {
      setState(() {
        isAdded = true;
      });
      try {
        await _fireStore
            .collection("Trainers")
            .doc(kCurrentUser?.email)
            .collection("reminders")
            .add({
          paramReminder: _messageController.text,
          paramCurrentStamp: currentDate,
        });
        setState(() {
          isAdded = false;
        });
        Navigator.pop(context);
        await _addEventToCalender(_messageController.text);
        showMessage("Reminder added successfully!");
        Navigator.pop(context);
        _messageController.clear();
      } catch (e) {
        showMessage("Add Reminder failed!");
      }
    }
  }

  _addEventToCalender(description) {
    final Event event = Event(
      title: kDueReminder,
      description: description,
      startDate: selectedStartDate,
      endDate: selectedEndDate,
    );
    Add2Calendar.addEvent2Cal(event);
  }
}
