import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/common/RoundedInputNewFormField.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:covid_project/service/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SuggestionContainer extends StatefulWidget {
  const SuggestionContainer({Key? key}) : super(key: key);

  @override
  _SuggestionContainerState createState() => _SuggestionContainerState();
}

class _SuggestionContainerState extends State<SuggestionContainer> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();
  var _message;
  var _name;

  void saveMessage(func) async {
    var user = await FirebaseAuthService().checkAuth();
    print(user!.uid);
    Map<String, dynamic> data = {
      'username': _name,
      'message': _message,
      'uid': user!.uid,
      'createdAt': FieldValue.serverTimestamp()
    };
    await FirebaseFirestore.instance
        .collection('feedback')
        .add(data)
        .then((value) {
      func();
    }).catchError((onError) {
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        scrollable: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Send Your Feedback",
              style: TextStyle(letterSpacing: 1),
            ),
          ],
        ),
        content: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: frmKey,
            child: Column(
              children: [
                RoundedInputFormFieldNew(
                  hintText: 'UserName',
                  onSaved: (name) {
                    _name = name;
                  },
                  validator: (name) {
                    if (name.toString().trim().isEmpty) {
                      return "Field is required";
                    }
                    return null;
                  },
                  icon: Icons.account_circle,
                  inputType: TextInputType.text,
                ),
                RoundedInputFormFieldNew(
                  hintText: 'Feedback',
                  onSaved: (message) {
                    _message = message;
                  },
                  validator: (message) {
                    if (message.toString().trim().isEmpty) {
                      return "Field is required";
                    }
                    return null;
                  },
                  icon: Icons.text_fields,
                  inputType: TextInputType.text,
                ),
                RoundedButton(
                  text: 'Add Feedback',
                  press: () {
                    if (frmKey.currentState!.validate()) {
                      frmKey.currentState!.save();
                      EasyLoading.show(status: 'Updating data...');
                      FocusScope.of(context).unfocus();
                      saveMessage(() {
                        EasyLoading.dismiss();
                        frmKey.currentState!.reset();
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
