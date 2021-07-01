import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:covid_project/user/CovidList.dart';
import 'package:covid_project/user/questionaries/QuestionaryScreen.dart';
import 'package:flutter/cupertino.dart';
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
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [],
              ),
              Text(
                'COVID-19 UPDATE',
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
              ),
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('covid')
                      .limit(1)
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return !snapshot.hasData
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            height: snapshot.data.docs.length > 0
                                ? size.height * 0.38
                                : size.height * 0.1,
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot data =
                                    snapshot.data.docs[index];

                                return CovidList(
                                    id: data.id,
                                    deaths: data['deaths'],
                                    createdAt: data['createdAt'],
                                    total: data['total'],
                                    recovered: data['recovered']);
                              },
                            ),
                          );
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              Container(child: QuestionaryScreen())
            ],
          )),
    );
  }
}
