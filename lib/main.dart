import 'package:covid_project/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';

import 'colorConstraint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'covid19-Project',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
