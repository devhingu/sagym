import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';

class TextFormFieldContainer extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType inputType;
  final EdgeInsetsGeometry margin;

  const TextFormFieldContainer({
    Key? key,
    required this.label, required this.obscureText, required this.inputType, required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
     margin:margin,
      child: TextFormField(
        obscureText: obscureText,
        style: kTextFormFieldTextStyle,
        decoration: InputDecoration(
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

  OutlineInputBorder textFormFieldInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: kGreyColor),
    );
  }
}
