import 'package:covid_project/SignIn/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        children: [
          Container(
            color: Colors.blueAccent,
            child: UserAccountsDrawerHeader(
                accountName: Text('Admin'),
                accountEmail: Text('Admin@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  onBackgroundImageError: (err, e) {},
                  backgroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/ctse-assignment-250c4.appspot.com/o/111.png?alt=media&token=7e9033cb-46a7-494a-a67c-7ab709f16438"),
                )),
          ),
          ListTile(
            title: Text(
              'Covid 19 Details',
              style: TextStyle(color: Color.fromRGBO(104, 24, 147, 1.0)),
            ),
            leading: Icon(
              Icons.coronavirus,
              color: Color.fromRGBO(104, 24, 147, 1.0),
            ),
          ),
          ListTile(
            title: Text(
              'Questionaries',
              style: TextStyle(color: Color.fromRGBO(104, 24, 147, 1.0)),
            ),
            leading: Icon(
              Icons.question_answer,
              color: Color.fromRGBO(104, 24, 147, 1.0),
            ),
          ),
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            title: Text(
              'SignOut',
              style: TextStyle(color: Color.fromRGBO(104, 24, 147, 1.0)),
            ),
            leading: Icon(
              Icons.logout,
              color: Color.fromRGBO(104, 24, 147, 1.0),
            ),
          )
        ],
      ),
    );
  }
}