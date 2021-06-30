import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'TaskListScreen.dart';

class TaskBodyContainer extends StatefulWidget {
  final bool isAdmin;
  const TaskBodyContainer({Key? key, required this.isAdmin}) : super(key: key);

  @override
  _TaskBodyContainerState createState() => _TaskBodyContainerState();
}

class _TaskBodyContainerState extends State<TaskBodyContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return TaskList(
                    isAdmin: widget.isAdmin,
                    id: data.id,
                    task: data['task'],
                    createdAt: data['createdAt'],
                    isFinished: data['finished'],
                  );
                },
              );
      },
    );
  }
}
