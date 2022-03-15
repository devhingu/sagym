import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../constants/text_style_constants.dart';
import '../utils/methods/reusable_methods.dart';

class TextFormFieldContainer extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String? value) onSubmit;
  final validator;

  const TextFormFieldContainer({
    Key? key,
    required this.label,
    required this.inputType,
    required this.controller,
    required this.focusNode,
    required this.onSubmit, this.validator,
  }) : super(key: key);

  @override
  State<TextFormFieldContainer> createState() => _TextFormFieldContainerState();
}

class _TextFormFieldContainerState extends State<TextFormFieldContainer> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        onFieldSubmitted: widget.onSubmit,
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: _isObscureText(),
        style: kTextFormFieldTextStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          border: textFormFieldInputBorder(),
          labelText: widget.label,
          labelStyle: kTextFormFieldLabelTextStyle,
          suffixIcon: widget.label.contains(kPassword)
              ? IconButton(
                  icon: Icon(
                    _isVisible ? Icons.visibility_off : Icons.visibility,
                    color: kGreyColor,
                  ),
                  onPressed: () {
                    if (widget.label.contains(kPassword)) {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    }
                  },
                )
              : null,
          focusedBorder: textFormFieldInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        keyboardType: widget.inputType,
      ),
    );
  }

  bool _isObscureText() {
    if (!_isVisible) {
      if (widget.label.contains(kPassword)) {
        return true;
      }
    }
    return false;
  }
}
