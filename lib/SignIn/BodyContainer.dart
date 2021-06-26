import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/SignIn/Background.dart';
import 'package:covid_project/SignUp/SignUpScreen.dart';
import 'package:covid_project/common/Account.dart';
import 'package:covid_project/common/RoundedInputFormField.dart';
import 'package:covid_project/common/RoundedPasswordField.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:covid_project/phi/PhiHomeScreen.dart';
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
  var _password;
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

  void signIn(BuildContext context, func) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: _emailAddress,
          password: _password,
        )
        .then((authUser) => {
              FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: authUser.user!.email)
                  .get()
                  .then((snapshot) {
                snapshot.docs.forEach((doc) {
                  if (doc['userlevel'] == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PHIHomeScreen()));
                  } else if (doc['userlevel'] == 2) {
                  } else {}
                });
                func();
                _showToast(
                    message: 'Successfully login!!',
                    color: Colors.greenAccent,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ));
              }).catchError((onError) {
                func();
                _showToast(
                    message: onError.message,
                    color: Colors.redAccent,
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ));
              }),
            })
        .catchError((onError) {
      func();
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
    });
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
                    EasyLoading.show(status: 'loading...');
                    FocusScope.of(context).unfocus();
                    signIn(context, () {
                      loginFormKey.currentState!.reset();
                      EasyLoading.dismiss();
                    });
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
