import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateImage extends StatelessWidget {
  final VoidCallback validate;
  final VoidCallback cancel;
  UpdateImage({
    Key? key,
    required this.validate,
    required this.cancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.done),
          style: ElevatedButton.styleFrom(
              primary: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          onPressed: validate,
          label: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Valider "),
          ),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.delete),
          style: ElevatedButton.styleFrom(
              primary: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          onPressed: cancel,
          label: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Annuler "),
          ),
        ),
      ],
    );
  }
}
