import 'package:covid_project/SignUp/Background.dart';
import 'package:covid_project/common/Account.dart';
import 'package:covid_project/common/RoundedInputFormField.dart';
import 'package:covid_project/common/RoundedPasswordField.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  var _emailAddress;
  var _password;
  var _cpassword;
  final TextEditingController passController = TextEditingController(text: "");
  late FToast fToast;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
        child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGNUP",
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(4, 78, 37, 1.0)),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "images/b2.svg",
              height: size.height * 0.32,
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
                } else if (password.toString().trim().length < 6) {
                  return 'password contain minimum 6 digits';
                }
                return null;
              },
              passController: passController,
            ),
            RoundedPasswordFormField(
              onSaved: (password) {
                _cpassword = password;
              },
              validator: (password) {
                if (password.toString().trim().isEmpty) {
                  return 'conform password is required';
                } else if (password.toString().trim() != passController.text) {
                  return 'password not match';
                }
                return null;
              },
              hintValue: 'Conform Password',
            ),
            RoundedButton(
                text: 'Signup',
                press: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    FocusScope.of(context).unfocus();
                  }
                }),
            SizedBox(
              height: size.height * 0.03,
            ),
            Account(
              press: () {},
              login: false,
            )
          ],
        ),
      ),
    ));
  }
}
