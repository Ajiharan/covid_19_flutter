import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CovidList extends StatefulWidget {
  final String id;
  final String total;
  final String recovered;
  final String deaths;
  final dynamic createdAt;

  const CovidList(
      {Key? key,
      required this.recovered,
      required this.deaths,
      required this.id,
      required this.createdAt,
      required this.total})
      : super(key: key);

  @override
  _CovidListState createState() => _CovidListState();
}

class _CovidListState extends State<CovidList> {
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 12,
        shadowColor: Colors.black12,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.coronavirus,
                        color: Colors.blue,
                        size: 35,
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Text(
                        'Total Cases : ${widget.total}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.dangerous,
                        color: Colors.red,
                        size: 35,
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Text(
                        'Total Deaths : ${widget.deaths}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: Colors.green,
                        size: 35,
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Text(
                        'Total Recovered : ${widget.recovered}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
