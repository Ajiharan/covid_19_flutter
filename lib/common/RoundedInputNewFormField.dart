import 'package:flutter/material.dart';
import '../colorConstraint.dart';
import 'TextNewFieldContainer.dart';

class RoundedInputFormFieldNew extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final onSaved;
  final validator;
  final TextInputType inputType;
  const RoundedInputFormFieldNew({
    Key? key,
    required this.hintText,
    this.icon = Icons.email,
    required this.onSaved,
    this.validator,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  _RoundedInputFormFieldNewState createState() =>
      _RoundedInputFormFieldNewState();
}

class _RoundedInputFormFieldNewState extends State<RoundedInputFormFieldNew> {
  @override
  Widget build(BuildContext context) {
    return TextFieldNewContainer(
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
            color: Colors.deepPurple,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
