import 'package:covid_project/SignIn/Background.dart';
import 'package:covid_project/SignUp/SignUpScreen.dart';
import 'package:covid_project/common/Account.dart';
import 'package:covid_project/common/RoundedInputFormField.dart';
import 'package:covid_project/common/RoundedPasswordField.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  var _emailAddress;
  var _password;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
        child: SingleChildScrollView(
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGNIN",
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(4, 78, 37, 1.0)),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "images/b1.svg",
              height: size.height * 0.3,
            ),
            RoundedInputFormField(
                hintText: 'Email Address',
                validator: (emailAddress) {
                  if (emailAddress.toString().trim().isEmpty) {
                    return "email id is required";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailAddress.toString().trim())) {
                    return "invalid email id";
                  }
                  return null;
                },
                onSaved: (emailAddress) {
                  _emailAddress = emailAddress;
                }),
            RoundedPasswordFormField(
              onSaved: (password) {
                _password = password;
              },
              validator: (password) {
                if (password.toString().trim().isEmpty) {
                  return 'password is required';
                }
                return null;
              },
            ),
            RoundedButton(
                text: 'SignIn',
                press: () {
                  if (loginFormKey.currentState!.validate()) {
                    loginFormKey.currentState!.save();
                    FocusScope.of(context).unfocus();
                  }
                }),
            SizedBox(
              height: size.height * 0.03,
            ),
            Account(
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              login: true,
            )
          ],
        ),
      ),
    ));
  }
}
