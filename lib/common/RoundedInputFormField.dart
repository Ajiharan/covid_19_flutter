import 'package:flutter/material.dart';

import '../colorConstraint.dart';
import 'TextFieldContainer.dart';

class RoundedInputFormField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final onSaved;
  final validator;
  final TextInputType inputType;
  const RoundedInputFormField({
    Key? key,
    required this.hintText,
    this.icon = Icons.email,
    required this.onSaved,
    this.validator,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  _RoundedInputFormFieldState createState() => _RoundedInputFormFieldState();
}

class _RoundedInputFormFieldState extends State<RoundedInputFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        keyboardType: widget.inputType,
        onSaved: (e) {
          this.widget.onSaved(e);
        },
        validator: (emailId) {
          return widget.validator(emailId);
        },
        cursorColor: PrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: PrimaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
