import 'package:covid_project/admin/task-management/TaskBodyContainer.dart';
import 'package:flutter/material.dart';

import '../AppBarHeader.dart';
import '../DrawerScreen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarHeader(),
          preferredSize: Size.fromHeight(size.height * 0.07)),
      drawer: DrawerScreen(),
      body: TaskBodyContainer(isAdmin: false),
    );
  }
}
