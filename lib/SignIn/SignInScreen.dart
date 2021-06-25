import 'package:covid_project/SignIn/BodyContainer.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          child: BodyContainer(),
          onTap: () => FocusScope.of(context).unfocus(),
        ),
      ),
    );
  }
}
