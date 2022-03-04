import 'package:flutter/material.dart';
import 'package:gym/constants/methods/reusable_methods.dart';

import '../constants/constants.dart';
import '../ui/dashboard/constants/dashboard_constants.dart';

class DropDownTextField extends StatefulWidget {
  final List<String> list;
  final String title;
  final FocusNode focusNode;
  final Function(String? value) onChanged;
  final String value;

  const DropDownTextField(
      {Key? key,
      required this.list,
      required this.title,
      required this.focusNode,
      required this.onChanged,
      required this.value})
      : super(key: key);

  @override
  State<DropDownTextField> createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  List<String> list = [];
  String title = "";

  @override
  void initState() {
    super.initState();
    list = widget.list;
    title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: DropdownButtonFormField(
        focusNode: widget.focusNode,
        items: list.map((String category) {
          return DropdownMenuItem(
            value: category,
            child: Text(
              category,
              style: kTextFormFieldTextStyle,
            ),
          );
        }).toList(),
        onChanged: widget.onChanged,
        value: widget.value,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            border: textFormFieldInputBorder(),
            labelText: title,
            labelStyle: kTextFormFieldLabelTextStyle,
            focusedBorder: textFormFieldInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }
}
