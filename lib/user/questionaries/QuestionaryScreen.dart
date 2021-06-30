import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/service/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionaryScreen extends StatefulWidget {
  const QuestionaryScreen({Key? key}) : super(key: key);

  @override
  _QuestionaryScreenState createState() => _QuestionaryScreenState();
}

class _QuestionaryScreenState extends State<QuestionaryScreen> {
  bool isQ1Checked = false;
  bool isQ2Checked = false;
  bool isQ3Checked = false;
  late FToast fToast;
  GlobalKey<FormState> questionKey = GlobalKey<FormState>();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Colors.lightBlue;
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast({message, color}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
  }

  void addQuestionaryData(func) async {
    var user = await FirebaseAuthService().checkAuth();
    print(user!.uid);
    Map<String, dynamic> data = {
      'isQ1Checked': isQ1Checked,
      'isQ2Checked': isQ2Checked,
      'isQ3Checked': isQ3Checked,
      'uid': user!.uid,
      'createdAt': FieldValue.serverTimestamp()
    };
    await FirebaseFirestore.instance
        .collection('questionnaires')
        .add(data)
        .then((value) {
      _showToast(color: Colors.greenAccent, message: 'Sucessfully added');
      func();
    }).catchError((onError) {
      _showToast(color: Colors.redAccent, message: onError.message);
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Form(
        key: questionKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Select as Many of the Symptoms as apply to you",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
            ),
            Card(
              elevation: 12,
              shadowColor: Colors.black12,
              child: Column(
                children: [
                  CheckboxListTile(
                      checkColor: Colors.white,
                      title: Text('A high temperature(fever)'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isQ1Checked,
                      onChanged: (value) {
                        setState(() {
                          isQ1Checked = value!;
                        });
                      }),
                  Divider(
                    color: Colors.black12,
                    height: 0.8,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "This means that you feel hot to touch on your chest or back - "
                      "you don't need to measure your temperature with a thermometer",
                      style: TextStyle(letterSpacing: 1, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            Card(
              elevation: 12,
              shadowColor: Colors.black12,
              child: Column(
                children: [
                  CheckboxListTile(
                      checkColor: Colors.white,
                      title: Text('A new Continuous cough'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isQ2Checked,
                      onChanged: (value) {
                        setState(() {
                          isQ2Checked = value!;
                        });
                      }),
                  Divider(
                    color: Colors.black12,
                    height: 0.8,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "This means coughing a lot for more than hour, or three or moew coughing episodes in 24 hours"
                      "(if you usually have a cough, it may be worse than usual)",
                      style: TextStyle(letterSpacing: 1, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            Card(
              elevation: 12,
              shadowColor: Colors.black12,
              child: Column(
                children: [
                  CheckboxListTile(
                      checkColor: Colors.white,
                      title: Text('A Change to your sense of smell or taste'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isQ3Checked,
                      onChanged: (value) {
                        setState(() {
                          isQ3Checked = value!;
                        });
                      }),
                  Divider(
                    color: Colors.black12,
                    height: 0.8,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "This means you have noticed that you cannot smell or taste anything, or that"
                      "things smell or taste different to normal.",
                      style: TextStyle(letterSpacing: 1, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 150, height: 40),
                child: ElevatedButton(
                  onPressed: () {
                    addQuestionaryData(() {
                      setState(() {
                        isQ1Checked = false;
                        isQ2Checked = false;
                        isQ3Checked = false;
                      });
                    });
                  },
                  child: Text('Submit'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
