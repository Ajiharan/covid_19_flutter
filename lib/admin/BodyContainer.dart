import 'package:covid_project/admin/task-management/TaskHomeScreen.dart';
import 'package:covid_project/admin/user-details/UserDetailsScreen.dart';
import 'package:covid_project/phi/DashboardIcon.dart';
import 'package:flutter/material.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: Row(
                  children: [
                    DashBoardIcon(
                        icon: Icons.task,
                        info: 'Assign Task',
                        number: '1',
                        backgroundColor:
                            Color.fromRGBO(250, 42, 42, 1.0).withOpacity(0.8),
                        circleCorlor: Color.fromRGBO(104, 24, 147, 1.0),
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskHomeScreen()));
                        }),
                    SizedBox(
                      width: size.width * 0.15,
                    ),
                    DashBoardIcon(
                        icon: Icons.account_box,
                        info: 'User Details',
                        number: '2',
                        backgroundColor:
                            Color.fromRGBO(56, 147, 70, 1.0).withOpacity(0.8),
                        circleCorlor: Color.fromRGBO(252, 224, 62, 1.0),
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailsScreen()));
                        })
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
