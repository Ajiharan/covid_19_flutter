import 'package:covid_project/phi/user_management/PHIUserScreen.dart';
import 'package:flutter/material.dart';

class AppBarHeader extends StatelessWidget {
  final bool? isShow;
  const AppBarHeader({Key? key, this.isShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'ADMIN DASHBOARD',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        isShow != null
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PHIUserBodyContainer()));
                },
                icon: Icon(Icons.backspace_sharp))
            : Text(''),
      ],
    );
  }
}
