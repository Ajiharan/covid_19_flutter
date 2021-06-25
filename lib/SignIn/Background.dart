import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 2,
            child: Image.asset(
              "images/main_top.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 2,
            left: 2,
            child: Image.asset(
              "images/main_bottom.png",
              width: size.width * 0.2,
            ),
          ),
          Positioned(
            top: 20,
            right: 2,
            child: RotatedBox(
              quarterTurns: 6,
              child: Image.asset(
                "images/main_bottom.png",
                width: size.width * 0.16,
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
