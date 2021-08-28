import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/user/AppBarHeader.dart';
import 'package:covid_project/user/UserDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UserBodyScreen.dart';
import '../common/cloud_messaging.dart' as CloudMessaging;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Future<void> getToken() async {
    try {
      var newToken = await FirebaseMessaging.instance.getToken();
      print('newToken ${newToken}');

      await FirebaseFirestore.instance
          .collection('message_tokens')
          .where('token', isEqualTo: newToken)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.length == 0) {
          try {
            Map<String, dynamic> map = {
              'token': newToken,
              'createdAt': FieldValue.serverTimestamp()
            };
            var result = await FirebaseFirestore.instance
                .collection('message_tokens')
                .add(map);
            print('results : $result');
          } catch (e) {
            print('Exception $e');
          }
        }
      });
    } catch (err) {
      print('Exception $err');
    }
  }

  @override
  void initState() {
    getToken();
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        CloudMessaging.flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                CloudMessaging.channel.id,
                CloudMessaging.channel.name,
                CloudMessaging.channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 248, 248, 0.4),
      appBar: PreferredSize(
          child: AppBarHeader(),
          preferredSize: Size.fromHeight(size.height * 0.21)),
      drawer: UserDrawer(),
      body: BodyContainer(),
    );
  }
}
