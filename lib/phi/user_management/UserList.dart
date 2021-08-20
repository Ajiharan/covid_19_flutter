import 'package:covid_project/phi/Questionary/QuestionaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserList extends StatefulWidget {
  final String id;
  final String username;
  final String email;
  final String uid;
  const UserList(
      {Key? key,
      required this.id,
      required this.email,
      required this.username,
      required this.uid})
      : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuestionaryScreen(uid: widget.uid)));
        },
        child: Card(
          elevation: 12,
          shadowColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: size.width - 80,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.id,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              onBackgroundImageError: (err, e) {},
                              backgroundImage: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/ctse-assignment-250c4.appspot.com/o/111.png?alt=media&token=7e9033cb-46a7-494a-a67c-7ab709f16438"),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.username,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.email,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
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
