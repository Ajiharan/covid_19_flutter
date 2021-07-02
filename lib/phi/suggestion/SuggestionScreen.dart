import 'package:flutter/material.dart';

import '../AppBarHeader.dart';
import '../suggestion/SuggestionBodyContainer.dart';
import '../DrawerScreen.dart';

class SuggestionScreen extends StatelessWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

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
