import 'package:flutter/material.dart';

class DashBoardIcon extends StatelessWidget {
  final icon;
  final info;
  final number;
  final backgroundColor;
  final circleCorlor;
  final Function press;

  const DashBoardIcon(
      {Key? key,
      required this.icon,
      required this.info,
      required this.number,
      required this.backgroundColor,
      required this.press,
      required this.circleCorlor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Container(
        width: size.width / 2 - 80,
        height: 170,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.transparent)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: IconButton(
                  icon: Icon(icon, color: circleCorlor, size: 35),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                info,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                number,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
