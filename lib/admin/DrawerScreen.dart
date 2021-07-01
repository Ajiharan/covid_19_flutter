import 'package:covid_project/SignIn/SignInScreen.dart';
import 'package:covid_project/admin/task-management/TaskHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('Admin@gmail.com'),
              currentAccountPicture: CircleAvatar(
                onBackgroundImageError: (err, e) {},
                backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/ctse-assignment-250c4.appspot.com/o/111.png?alt=media&token=7e9033cb-46a7-494a-a67c-7ab709f16438"),
              )),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TaskHomeScreen()));
            },
            title: Text(
              'Task',
              style: TextStyle(color: Color.fromRGBO(210, 10, 27, 1.0)),
            ),
            leading: Icon(
              Icons.task,
              color: Color.fromRGBO(210, 10, 27, 1.0),
            ),
          ),
          ListTile(
            title: Text(
              'User Details',
              style: TextStyle(color: Color.fromRGBO(51, 118, 234, 1.0)),
            ),
            leading: Icon(
              Icons.account_circle_rounded,
              color: Color.fromRGBO(51, 118, 234, 1.0),
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
              style: TextStyle(color: Color.fromRGBO(30, 30, 40, 1.0)),
            ),
            leading: Icon(
              Icons.logout,
              color: Color.fromRGBO(37, 39, 42, 1.0),
            ),
          )
        ],
      ),
    );
  }
}
