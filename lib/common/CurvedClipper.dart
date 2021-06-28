import 'package:flutter/cupertino.dart';

class CurvedClipper extends ContinuousRectangleBorder {
  const CurvedClipper(this.curveheights);
  final double curveheights;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()
    ..lineTo(0, rect.size.height)
    ..quadraticBezierTo(
        rect.size.width / 2,
        rect.size.height + curveheights * 2,
        rect.size.width,
        rect.size.height)
    ..lineTo(rect.size.width, 0)
    ..close();
}

// import 'package:flutter/cupertino.dart';
//
// class CurvedClipper extends ContinuousRectangleBorder {
//   const CurvedClipper(this.curveheights);
//   final double curveheights;
//   final double innerCircleRadius = 150.0;
//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     final double innerCircleRadius = 150.0;
//
//     Path path = Path();
//     path.lineTo(0, rect.height);
//     path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30,
//         rect.height + 15, rect.width / 2 - 75, rect.height + 50);
//     path.cubicTo(
//         rect.width / 2 - 40,
//         rect.height + innerCircleRadius - 40,
//         rect.width / 2 + 40,
//         rect.height + innerCircleRadius - 40,
//         rect.width / 2 + 75,
//         rect.height + 50);
//     path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30,
//         rect.height + 15, rect.width, rect.height);
//     path.lineTo(rect.width, 0.0);
//     path.close();
//
//     return path;
//   }
// }
