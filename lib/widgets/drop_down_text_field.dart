import 'package:flutter/material.dart';
import '../constants/text_style_constants.dart';
import '../utils/methods/reusable_methods.dart';

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
          return _dropDownMenuItem(category);
        }).toList(),
        onChanged: widget.onChanged,
        value: widget.value,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          border: textFormFieldInputBorder(),
          labelText: title,
          labelStyle: kTextFormFieldLabelTextStyle,
          focusedBorder: textFormFieldInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  DropdownMenuItem<String> _dropDownMenuItem(String category) =>
      DropdownMenuItem(
        value: category,
        child: Text(
          category,
          style: kTextFormFieldTextStyle,
        ),
      );
}
