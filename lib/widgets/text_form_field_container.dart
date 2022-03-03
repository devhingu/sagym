import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

class TextFormFieldContainer extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String? value) onSubmit;

  const TextFormFieldContainer({
    Key? key,
    required this.label,
    required this.inputType,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22.0),
      child: TextFormField(
        onFieldSubmitted: onSubmit,
        focusNode: focusNode,
        controller: controller,
        obscureText: label == "Password" ? true : false,
        style: kTextFormFieldTextStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          border: textFormFieldInputBorder(),
          labelText: label,
          labelStyle: kTextFormFieldLabelTextStyle,
          focusedBorder: textFormFieldInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //suffixIcon: label == "Password" ? Icon(CupertinoIcons.eye) : null,
        ),
        keyboardType: inputType,
      ),
    );
  }
}
