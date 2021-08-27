import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/service/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import '../../common/cloud_messaging.dart' as CloudMessaging;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class AwarnessAlertBody extends StatefulWidget {
  final bool isAdmin;
  final bool isAwarness;
  const AwarnessAlertBody(
      {Key? key, required this.isAdmin, required this.isAwarness})
      : super(key: key);

  @override
  _AwarnessAlertBodyState createState() => _AwarnessAlertBodyState();
}

class _AwarnessAlertBodyState extends State<AwarnessAlertBody> {
  GlobalKey<FormState> chatkey = GlobalKey<FormState>();
  String? _message;

  void addMessage(func) async {
    var user = await FirebaseAuthService().checkAuth();
    print(user);
    Map<String, dynamic> data = {
      'message': _message,
      'uid': user!.uid,
      'userName': user!.displayName,
      'createdAt': FieldValue.serverTimestamp()
    };
    await FirebaseFirestore.instance
        .collection('chats')
        .add(data)
        .then((value) {
      func();
    }).catchError((onError) {
      func();
      print(onError.message);
    });
  }

  String constructFCMPayload(String message) {
    return jsonEncode({
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': message,
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification was created via FCM!',
      },
    });
  }

  Future<void> sendPushMessage(message) async {
    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(message),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  void updateNotification(_message) {
    CloudMessaging.flutterLocalNotificationsPlugin.show(
        0,
        "Admin Notification",
        _message,
        NotificationDetails(
            android: AndroidNotificationDetails(
          CloudMessaging.channel.id,
          CloudMessaging.channel.name,
          CloudMessaging.channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
        )));
  }

  void addAdminMessage(func) async {
    var user = await FirebaseAuthService().checkAuth();
    print(user);
    Map<String, dynamic> data = {
      'message': _message,
      'uid': user!.uid,
      'userName': 'admin',
      'createdAt': FieldValue.serverTimestamp()
    };
    await FirebaseFirestore.instance
        .collection('awrness')
        .add(data)
        .then((value) {
      func();
      sendPushMessage(_message);
    }).catchError((onError) {
      func();
      print(onError.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 80),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("awrness")
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];
                          return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (data['uid'] !=
                                      FirebaseAuthService().checkAuth()!.uid
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Column(
                                crossAxisAlignment: data['uid'] !=
                                        FirebaseAuthService().checkAuth()!.uid
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    data['userName'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: (data['uid'] !=
                                              FirebaseAuthService()
                                                  .checkAuth()!
                                                  .uid
                                          ? Colors.grey.shade200
                                          : Colors.blue[200]),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      data['message'],
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          widget.isAdmin
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Form(
                          key: chatkey,
                          child: Expanded(
                            child: TextFormField(
                              onSaved: (message) {
                                _message = message;
                              },
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            chatkey.currentState!.save();
                            if (widget.isAdmin) {
                              addAdminMessage(() {
                                chatkey.currentState!.reset();
                              });
                            } else {
                              addMessage(() {
                                chatkey.currentState!.reset();
                              });
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
