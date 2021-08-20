import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/SignIn/Background.dart';
import 'package:covid_project/SignIn/SignInScreen.dart';
import 'package:covid_project/SignUp/SignUpScreen.dart';
import 'package:covid_project/admin/AdminHomeScreen.dart';
import 'package:covid_project/colorConstraint.dart';
import 'package:covid_project/common/Account.dart';
import 'package:covid_project/common/RoundedInputFormField.dart';
import 'package:covid_project/common/RoundedPasswordField.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:covid_project/phi/PhiHomeScreen.dart';
import 'package:covid_project/service/FirebaseAuthService.dart';
import 'package:covid_project/user/UserHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  var _emailAddress;

  var fToast;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast({message, color, icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  Future sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

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
              "Forgot Password",
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(4, 78, 37, 1.0)),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "images/c1.svg",
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
            RoundedButton(
                text: 'Send Email',
                press: () async {
                  if (loginFormKey.currentState!.validate()) {
                    loginFormKey.currentState!.save();
                    // EasyLoading.show(status: 'loading...');
                    // FocusScope.of(context).unfocus();
                    // EasyLoading.dismiss();
                    await sendPasswordResetEmail(
                        _emailAddress.toString().trim());
                    _showToast(
                        message: 'email verification send sucessfully',
                        color: Colors.greenAccent,
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ));
                  }
                }),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: Text(
                "back to login",
                style: TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
