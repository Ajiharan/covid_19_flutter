import 'package:covid_project/common/CurvedClipper.dart';
import 'package:flutter/material.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(70, 151, 238, 1.0),
      bottomOpacity: 0.2,
      elevation: 5,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150))),
      title: Text(
        'USER DASHBOARD',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
