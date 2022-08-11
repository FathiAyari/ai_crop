import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class UploadImage extends StatelessWidget {
  final VoidCallback press;
  UploadImage({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Constants.blueCustomColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: press,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text("Choisir une image "),
      ),
    );
  }
}
