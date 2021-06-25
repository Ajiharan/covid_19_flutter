import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/SignIn/SignInScreen.dart';
import 'package:covid_project/SignUp/Background.dart';
import 'package:covid_project/common/Account.dart';
import 'package:covid_project/common/RoundedInputFormField.dart';
import 'package:covid_project/common/RoundedPasswordField.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  var _username;
  final TextEditingController passController = TextEditingController(text: "");
  late FToast fToast;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void signUp(BuildContext context, func) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: _emailAddress,
          password: _password,
        )
        .then((authUser) => {
              saveUserData(func),
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

  void saveUserData(func) {
    Map<String, dynamic> userData = {
      "username": _username,
      "email": _emailAddress,
      "userlevel": 0
    };
    FirebaseFirestore.instance.collection("users").add(userData).then((value) {
      func();
      _showToast(
          message: 'Successfully registered!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignInScreen()));
    }).catchError((onError) {
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
                hintText: 'UserName',
                icon: Icons.account_circle_rounded,
                validator: (name) {
                  if (name.toString().trim().isEmpty) {
                    return "userName is required";
                  }
                  return null;
                },
                onSaved: (name) {
                  _username = name;
                }),
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
                    EasyLoading.show(status: 'loading...');
                    // print(_emailAddress);
                    FocusScope.of(context).unfocus();
                    signUp(context, () {
                      EasyLoading.dismiss();
                      formKey.currentState!.reset();
                      passController.clear();
                    });
                  }
                }),
            SizedBox(
              height: size.height * 0.03,
            ),
            Account(
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              login: false,
            )
          ],
        ),
      ),
    ));
  }
}
