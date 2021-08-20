import 'package:covid_project/forgot_password/BodyContainer.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
