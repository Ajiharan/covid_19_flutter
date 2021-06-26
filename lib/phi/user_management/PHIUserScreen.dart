import 'package:covid_project/phi/user_management/UserBodyContainer.dart';
import 'package:flutter/material.dart';

import '../AppBarHeader.dart';
import '../DrawerScreen.dart';

class PHIUserBodyContainer extends StatelessWidget {
  const PHIUserBodyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarHeader(),
          preferredSize: Size.fromHeight(size.height * 0.07)),
      drawer: DrawerScreen(),
      body: UserBodyContainer(),
    );
  }
}
