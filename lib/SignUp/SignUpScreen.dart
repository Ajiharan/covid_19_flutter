import 'package:covid_project/SignUp/BodyContainer.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: BodyContainer(),
        onTap: () => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
