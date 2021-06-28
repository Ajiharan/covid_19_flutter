import 'package:covid_project/user/AppBarHeader.dart';
import 'package:covid_project/user/UserDrawer.dart';
import 'package:flutter/material.dart';
import 'UserBodyScreen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
