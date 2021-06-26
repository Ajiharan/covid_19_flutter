import 'package:flutter/material.dart';

class AppBarHeader extends StatelessWidget {
  const AppBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'ADMIN DASHBOARD',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
