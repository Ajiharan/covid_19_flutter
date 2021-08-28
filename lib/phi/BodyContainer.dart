import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/phi/suggestion/SuggestionScreen.dart';
import 'package:covid_project/phi/task-phi/TaskScreen.dart';
import 'package:covid_project/phi/user_management/PHIUserScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DashboardIcon.dart';
import 'awarness-alert/AwarnessAlertScreen.dart';
import 'division_management/DivisionHomeScreen.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);
  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  Future<void> removeToken() async {
    try {
      var newToken = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection('message_tokens')
          .where('token', isEqualTo: newToken)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          FirebaseFirestore.instance
              .collection('message_tokens')
              .doc(doc.id)
              .delete();
        });
      });
    } catch (err) {
      print('Exception $err');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    removeToken();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Row(
                children: [
                  DashBoardIcon(
                      icon: Icons.account_balance,
                      info: 'Divisional details',
                      number: '1',
                      backgroundColor:
                          Color.fromRGBO(33, 145, 217, 1.0).withOpacity(0.8),
                      circleCorlor: Color.fromRGBO(234, 99, 99, 1.0),
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DivisionHomeScreen()));
                      }),
                  SizedBox(
                    width: size.width * 0.15,
                  ),
                  DashBoardIcon(
                      icon: Icons.account_box,
                      info: 'User details',
                      number: '2',
                      backgroundColor:
                          Color.fromRGBO(227, 127, 38, 1.0).withOpacity(0.8),
                      circleCorlor: Color.fromRGBO(53, 97, 173, 1.0),
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PHIUserBodyContainer()));
                      })
                ],
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Row(
                children: [
                  DashBoardIcon(
                      icon: Icons.notification_important,
                      info: 'Awarness Alert',
                      number: '3',
                      backgroundColor:
                          Color.fromRGBO(250, 42, 42, 1.0).withOpacity(0.8),
                      circleCorlor: Color.fromRGBO(104, 24, 147, 1.0),
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AwarnessAlertScreen()));
                      }),
                  SizedBox(
                    width: size.width * 0.15,
                  ),
                  DashBoardIcon(
                      icon: Icons.account_box,
                      info: 'Suggestion',
                      number: '4',
                      backgroundColor:
                          Color.fromRGBO(56, 147, 70, 1.0).withOpacity(0.8),
                      circleCorlor: Color.fromRGBO(252, 224, 62, 1.0),
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuggestionScreen()));
                      })
                ],
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Row(
                children: [
                  DashBoardIcon(
                      icon: Icons.task,
                      info: 'My Task',
                      number: '5',
                      backgroundColor:
                          Color.fromRGBO(194, 26, 113, 1.0).withOpacity(0.8),
                      circleCorlor: Color.fromRGBO(57, 213, 29, 1.0),
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskScreen()));
                      }),
                  SizedBox(
                    width: size.width * 0.15,
                  ),
                  DashBoardIcon(
                      icon: Icons.report,
                      info: 'Report',
                      number: '6',
                      backgroundColor:
                          Color.fromRGBO(82, 72, 72, 1.0).withOpacity(0.8),
                      circleCorlor: Color.fromRGBO(210, 10, 27, 1.0),
                      press: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             PHIUserBodyContainer()));
                      })
                ],
              ))
        ],
      ),
    );
  }
}
