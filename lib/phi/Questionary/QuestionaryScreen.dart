import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../AppBarHeader.dart';
import '../DrawerScreen.dart';
import 'QuestionaryList.dart';

class QuestionaryScreen extends StatelessWidget {
  final String uid;
  const QuestionaryScreen({Key? key, required this.uid}) : super(key: key);

  Stream<QuerySnapshot>? getsnapShot() {
    try{
      var query = FirebaseFirestore.instance
          .collection('questionnaires')
          .where(
        'uid',
        isEqualTo: uid,
      )
          .orderBy('createdAt', descending: false);
      var snapShot = query.snapshots();
      return snapShot;
    }catch(err){
      print(err);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: AppBarHeader(
            isShow: true,
          ),
          preferredSize: Size.fromHeight(size.height * 0.07)),
      drawer: DrawerScreen(),
      body: StreamBuilder(
        stream: getsnapShot(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return QuestionaryListData(
                        id: data.id,
                        isQ1Checked: data['isQ1Checked'],
                        isQ2Checked: data['isQ2Checked'],
                        isQ3Checked: data['isQ3Checked']);
                  },
                );
        },
      ),
    );
  }
}
