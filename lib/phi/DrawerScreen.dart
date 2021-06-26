import 'package:covid_project/SignIn/SignInScreen.dart';
import 'package:covid_project/phi/PhiHomeScreen.dart';
import 'package:covid_project/phi/division_management/DivisionHomeScreen.dart';
import 'package:covid_project/phi/user_management/PHIUserScreen.dart';
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
                  MaterialPageRoute(builder: (context) => PHIHomeScreen()));
            },
            title: Text(
              'Home',
              style: TextStyle(color: Color.fromRGBO(227, 34, 232, 1.0)),
            ),
            leading: Icon(
              Icons.home,
              color: Color.fromRGBO(227, 34, 232, 1.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DivisionHomeScreen()));
            },
            title: Text(
              'Divisional details',
              style: TextStyle(color: Color.fromRGBO(234, 99, 99, 1.0)),
            ),
            leading: Icon(
              Icons.account_balance,
              color: Color.fromRGBO(234, 99, 99, 1.0),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PHIUserBodyContainer()));
            },
            title: Text(
              'User details',
              style: TextStyle(color: Color.fromRGBO(53, 97, 173, 1.0)),
            ),
            leading: Icon(
              Icons.account_box,
              color: Color.fromRGBO(53, 97, 173, 1.0),
            ),
          ),
          ListTile(
            title: Text(
              'Awarness Alert',
              style: TextStyle(color: Color.fromRGBO(104, 24, 147, 1.0)),
            ),
            leading: Icon(
              Icons.notification_important,
              color: Color.fromRGBO(104, 24, 147, 1.0),
            ),
          ),
          ListTile(
            title: Text(
              'Suggestion ',
              style: TextStyle(color: Color.fromRGBO(252, 224, 62, 1.0)),
            ),
            leading: Icon(
              Icons.account_box,
              color: Color.fromRGBO(252, 224, 62, 1.0),
            ),
          ),
          ListTile(
            title: Text(
              'My Task ',
              style: TextStyle(color: Color.fromRGBO(57, 213, 29, 1.0)),
            ),
            leading: Icon(
              Icons.task,
              color: Color.fromRGBO(57, 213, 29, 1.0),
            ),
          ),
          ListTile(
            title: Text(
              'Report',
              style: TextStyle(color: Color.fromRGBO(210, 10, 27, 1.0)),
            ),
            leading: Icon(
              Icons.report,
              color: Color.fromRGBO(210, 10, 27, 1.0),
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
