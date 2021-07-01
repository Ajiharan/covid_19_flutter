import 'package:flutter/material.dart';

import '../AppBarHeader.dart';
import '../UserDrawer.dart';
import 'SuggestionContainer.dart';

class SuggestionScreen extends StatelessWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 248, 248, 0.4),
      appBar: PreferredSize(
          child: AppBarHeader(),
          preferredSize: Size.fromHeight(size.height * 0.21)),
      drawer: UserDrawer(),
      body: SuggestionContainer(),
    );
  }
}
