import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../constants/constants.dart';
import '../home_page.dart';
import '../onboarding/on_boarding_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplasScreenState createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplashScreen> {
  var seen = GetStorage().read("seen");
  var auth = GetStorage().read("auth");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4), () => Get.to(seen == 1 ? HomePage() : OnBoardingPage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: Constants.screenHeight * 0.2,
            ),
            Lottie.asset(
              "assets/images/guy.json",
              height: Constants.screenHeight * 0.3,
            ),
            SizedBox(
              height: Constants.screenHeight * 0.1,
            ),
            Container(
              width: double.infinity,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "AI Quality",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 40,
                      fontFamily: 'NunitoBold',
                    ),
                    speed: Duration(milliseconds: 40),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Constants.screenHeight * 0.06,
            ),
            Lottie.asset(
              "assets/images/loading.json",
              height: size.height * 0.1,
            )
          ],
        ));
  }
}
