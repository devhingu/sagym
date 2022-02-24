import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';

class TextFormFieldContainer extends StatelessWidget {
  final String label;
  final bool obscureText;

  const TextFormFieldContainer({
    Key? key,
    required this.label, required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      child: TextFormField(
        obscureText: obscureText,
        style: kTextFormFieldTextStyle,
        decoration: InputDecoration(
          border: textFormFieldInputBorder(),
          labelText: label,
          labelStyle: kTextFormFieldLabelTextStyle,
          focusedBorder: textFormFieldInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  OutlineInputBorder textFormFieldInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: kGreyColor),
    );
  }
}
