import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/phi/user_management/UserList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserBodyContainer extends StatefulWidget {
  const UserBodyContainer({Key? key}) : super(key: key);

  @override
  _UserBodyContainerState createState() => _UserBodyContainerState();
}

class _UserBodyContainerState extends State<UserBodyContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userlevel', isEqualTo: 0)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return UserList(
                      id: data.id,
                      email: data['email'],
                      uid: data['uid'],
                      username: data['username']);
                },
              );
      },
    );
  }
}
