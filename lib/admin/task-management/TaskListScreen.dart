import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskList extends StatefulWidget {
  final String id;
  final String task;
  final dynamic createdAt;
  final bool isFinished;
  final bool isAdmin;
  const TaskList(
      {Key? key,
      required this.isAdmin,
      required this.id,
      required this.task,
      required this.createdAt,
      required this.isFinished})
      : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  void deleteRecord(id, func) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .delete()
        .then((value) {
      Fluttertoast.showToast(
          msg: "Sucessfully Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
      func();
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    });
  }

  void updateRecord(id, func) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .update({'finished': !widget.isFinished}).then((value) {
      // Fluttertoast.showToast(
      //     msg: "Sucessfully Deleted",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 15.0);
      func();
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 12,
        shadowColor: Colors.black12,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.task,
                        color: Colors.blue,
                        size: 35,
                      ),
                      Flexible(
                        child: Text(
                          widget.task,
                          style: TextStyle(
                              decoration: widget.isFinished
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (widget.isAdmin) {
                              deleteRecord(widget.id, () {});
                            } else {
                              updateRecord(widget.id, () {});
                            }
                          },
                          icon: widget.isAdmin
                              ? Icon(Icons.delete, color: Colors.red)
                              : widget.isFinished
                                  ? Icon(Icons.done, color: Colors.green)
                                  : Icon(Icons.info, color: Colors.yellow))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
