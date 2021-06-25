import 'package:covid_project/colorConstraint.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final bool login;
  final Function press;
  const Account({Key? key, this.login = true, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: PrimaryColor),
        ),
        GestureDetector(
          onTap: () {
            press();
          },
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: PrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
