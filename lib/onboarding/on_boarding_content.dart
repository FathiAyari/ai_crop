import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/constants.dart';

class Content extends StatelessWidget {
  final String title;
  final String img;
  final String description;

  const Content({Key? key, required this.title, required this.img, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.1 ,horizontal: Constants.screenWidth * 0.1),
                child: Text(
                  "$title",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Nunito", color: Colors.blueAccent, fontSize: 30),
                ),
              ),
              Lottie.asset(img, height: Constants.screenHeight * 0.3),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Text(
                  "$description",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Nunito", color: Colors.blueAccent, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
