import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'CovidList.dart';

class DivisionBodyContainer extends StatefulWidget {
  const DivisionBodyContainer({Key? key}) : super(key: key);

  @override
  _DivisionBodyContainerState createState() => _DivisionBodyContainerState();
}

class _DivisionBodyContainerState extends State<DivisionBodyContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('covid')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return CovidList(
                      id: data.id,
                      deaths: data['deaths'],
                      createdAt: data['createdAt'],
                      total: data['total'],
                      recovered: data['recovered']);
                },
              );
      },
    );
  }
}
