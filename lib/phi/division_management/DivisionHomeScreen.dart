import 'package:covid_project/common/RoundedInputFormField.dart';
import 'package:covid_project/common/RoundedInputNewFormField.dart';
import 'package:flutter/material.dart';

import '../AppBarHeader.dart';
import '../DrawerScreen.dart';
import 'DivisionBodyContainer.dart';

class DivisionHomeScreen extends StatefulWidget {
  const DivisionHomeScreen({Key? key}) : super(key: key);

  @override
  _DivisionHomeScreenState createState() => _DivisionHomeScreenState();
}

class _DivisionHomeScreenState extends State<DivisionHomeScreen> {
  void show() {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            scrollable: true,
            title: Text("Add Division details"),
            content: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                child: Column(
                  children: [
                    RoundedInputFormFieldNew(
                      hintText: 'Total Cases count',
                      onSaved: () {},
                      icon: Icons.coronavirus_sharp,
                      inputType: TextInputType.number,
                    ),
                    RoundedInputFormFieldNew(
                      hintText: 'Total Deaths count',
                      onSaved: () {},
                      icon: Icons.report_outlined,
                    ),
                    RoundedInputFormFieldNew(
                      hintText: 'Recovered count',
                      onSaved: () {},
                      icon: Icons.medical_services,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarHeader(),
          preferredSize: Size.fromHeight(size.height * 0.07)),
      drawer: DrawerScreen(),
      body: DivisionBodyContainer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          show();
        },
        label: const Text('Add Details'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
