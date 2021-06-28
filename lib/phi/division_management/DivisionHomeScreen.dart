import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_project/common/RoundedInputFormField.dart';
import 'package:covid_project/common/RoundedInputNewFormField.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../AppBarHeader.dart';
import '../DrawerScreen.dart';
import 'DivisionBodyContainer.dart';

class DivisionHomeScreen extends StatefulWidget {
  const DivisionHomeScreen({Key? key}) : super(key: key);

  @override
  _DivisionHomeScreenState createState() => _DivisionHomeScreenState();
}

class _DivisionHomeScreenState extends State<DivisionHomeScreen> {
  GlobalKey<FormState> frmKey = GlobalKey<FormState>();
  var _totalPopulation;
  var _totalDeath;
  var _totalRecovered;
  late FToast fToast;

  _showToast({message, color, icon}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  void saveCovidData(func) {
    Map<String, dynamic> userData = {
      "total": _totalPopulation,
      "deaths": _totalDeath,
      "recovered": _totalRecovered,
      "createdAt": FieldValue.serverTimestamp()
    };
    FirebaseFirestore.instance.collection("covid").add(userData).then((value) {
      _showToast(
          message: 'Successfully Added!!',
          color: Colors.greenAccent,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ));
      func();
    }).catchError((onError) {
      _showToast(
          message: onError.message,
          color: Colors.redAccent,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ));
      func();
    });
  }

  void show() {
    showDialog(
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            scrollable: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ADD COVID DETAILS",
                  style: TextStyle(letterSpacing: 1),
                ),
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.redAccent),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )))
              ],
            ),
            content: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: frmKey,
                child: Column(
                  children: [
                    RoundedInputFormFieldNew(
                      hintText: 'Total Cases count',
                      onSaved: (totalPopulation) {
                        _totalPopulation = totalPopulation;
                      },
                      validator: (totalPopulation) {
                        if (totalPopulation.toString().trim().isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      icon: Icons.coronavirus_sharp,
                      inputType: TextInputType.number,
                    ),
                    RoundedInputFormFieldNew(
                      hintText: 'Total Deaths count',
                      onSaved: (totalDeath) {
                        _totalDeath = totalDeath;
                      },
                      inputType: TextInputType.number,
                      validator: (totalDeath) {
                        if (totalDeath.toString().trim().isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      icon: Icons.report_outlined,
                    ),
                    RoundedInputFormFieldNew(
                      hintText: 'Recovered count',
                      inputType: TextInputType.number,
                      onSaved: (totalRecovered) {
                        _totalRecovered = totalRecovered;
                      },
                      validator: (totalRecovered) {
                        if (totalRecovered.toString().trim().isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      icon: Icons.medical_services,
                    ),
                    RoundedButton(
                      text: 'Add Detail',
                      press: () {
                        if (frmKey.currentState!.validate()) {
                          frmKey.currentState!.save();
                          EasyLoading.show(status: 'Updating data...');
                          FocusScope.of(context).unfocus();
                          saveCovidData(() {
                            EasyLoading.dismiss();
                            frmKey.currentState!.reset();
                          });
                        }
                      },
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
