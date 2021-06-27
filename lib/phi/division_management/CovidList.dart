import 'package:flutter/material.dart';

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
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                0.9
              ], colors: [
                Color.fromRGBO(71, 69, 69, 0.8),
                Color.fromRGBO(14, 14, 14, 0.7019607843137254),
              ])),
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.coronavirus,
                        color: Colors.blue,
                        size: 35,
                      ),
                      Text(
                        'Total Cases : ${widget.total}',
                        style: TextStyle(
                            color: Colors.white,
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
                      Text(
                        'Total Deaths : ${widget.deaths}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
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
                      Text(
                        'Total Recovered : ${widget.recovered}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )
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
