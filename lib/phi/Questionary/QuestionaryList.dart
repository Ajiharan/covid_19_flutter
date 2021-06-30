import 'package:flutter/material.dart';

class QuestionaryListData extends StatefulWidget {
  final bool isQ1Checked;
  final bool isQ2Checked;
  final bool isQ3Checked;
  final String id;
  const QuestionaryListData(
      {Key? key,
      required this.isQ2Checked,
      required this.isQ3Checked,
      required this.isQ1Checked,
      required this.id})
      : super(key: key);

  @override
  _QuestionaryListDataState createState() => _QuestionaryListDataState();
}

class _QuestionaryListDataState extends State<QuestionaryListData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'A high temperature(fever) : ',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.isQ1Checked ? 'Yes' : 'No',
                    style: TextStyle(
                        fontSize: 15,
                        color: widget.isQ1Checked
                            ? Color.fromRGBO(37, 172, 65, 1.0)
                            : Color.fromRGBO(206, 62, 38, 1.0)),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'A new Continuous cough : ',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.isQ2Checked ? 'Yes' : 'No',
                    style: TextStyle(
                        fontSize: 15,
                        color: widget.isQ2Checked
                            ? Color.fromRGBO(37, 172, 65, 1.0)
                            : Color.fromRGBO(206, 62, 38, 1.0)),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black26,
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'A Change to your sense of smell or taste : ${widget.isQ3Checked ? 'Yes' : 'No'} ',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
