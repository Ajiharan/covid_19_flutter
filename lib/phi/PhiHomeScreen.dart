import 'package:covid_project/phi/AppBarHeader.dart';
import 'package:covid_project/phi/DrawerScreen.dart';
import 'package:flutter/material.dart';

import 'BodyContainer.dart';

class PHIHomeScreen extends StatelessWidget {
  const PHIHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarHeader(),
          preferredSize: Size.fromHeight(size.height * 0.07)),
      drawer: DrawerScreen(),
      body: BodyContainer(),
    );
  }
}
