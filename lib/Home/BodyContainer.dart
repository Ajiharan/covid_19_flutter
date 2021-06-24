import 'package:covid_project/Home/BackGround.dart';
import 'package:covid_project/colorConstraint.dart';
import 'package:covid_project/common/rounded_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      key: null,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "COVID SAFE",
              style: TextStyle(
                  color: Color.fromRGBO(2, 68, 22, 1.0), fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SvgPicture.asset(
              "images/s10.svg",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              press: () {},
              text: 'Login',
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              press: () {},
              text: 'Signup',
              color: PrimaryLightColor,
            )
          ],
        ),
      ),
    );
  }
}
