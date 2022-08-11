import 'dart:io';

import 'package:ai_crop/widgets/alert_widgets.dart';
import 'package:ai_crop/widgets/edit_image.dart';
import 'package:ai_crop/widgets/upload_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

import 'constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FloatingActionButtonLocation floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked;
  double height = Constants.screenHeight * 0.7;
  File? _image;
  bool done = false;
  Future getImage() async {
    ImageSource? imageSource;
    NAlertDialog(
      title: Column(
        children: [
          Image.asset("assets/images/dexclamation.png", height: Constants.screenHeight * 0.06, color: Colors.red),
          Text(
            "Choisir le source de l'image",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "NunitoBold",
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  imageSource = ImageSource.camera;
                });
                if (imageSource != null) {
                  final image = await ImagePicker().pickImage(
                    source: imageSource!,
                  );
                  setState(() {
                    _image = File(image!.path);
                  });
                }
              },
              child: Text("Camera")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  imageSource = ImageSource.gallery;
                });
                if (imageSource != null) {
                  final image = await ImagePicker().pickImage(
                    source: imageSource!,
                  );
                  setState(() {
                    _image = File(image!.path);
                  });
                }
              },
              child: Text("Gallerie")),
        ),
      ],
      blur: 2,
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  deleteImage() {
    NAlertDialog(
      title: Column(
        children: [
          Image.asset("assets/images/dexclamation.png", height: Constants.screenHeight * 0.06, color: Colors.red),
          Text(
            "Vous etes sur d'annuler?",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "NunitoBold",
            ),
          ),
        ],
      ),
      actions: [
        Negative(),
        Positive(() {
          setState(() {
            floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked;
            height = Constants.screenHeight * 0.7;
            _image = null;
          });
          Navigator.pop(context);
        })
      ],
      blur: 2,
    ).show(context, transitionType: DialogTransitionType.Bubble);
  }

  Widget edit() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () async {
              await GallerySaver.saveImage(_image!.path).then((value) {
                setState(() {
                  done = false;
                  height = Constants.screenHeight * 0.7;
                  floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked;
                  _image = null;
                });
                Fluttertoast.showToast(
                    msg: "Image sauvegardée dans la gallerie",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0);
              });
            },
            child: Icon(Icons.download_rounded),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                done = false;
                height = Constants.screenHeight * 0.7;
                floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked;
                _image = null;
              });
            },
            child: Icon(Icons.download_rounded),
          ),
        ),
      ],
    );
  }

  Future<bool> avoidReturnButton() async {
    NAlertDialog(
      title: Column(
        children: [
          Image.asset("assets/images/dexclamation.png", height: Constants.screenHeight * 0.06, color: Colors.red),
          Text(
            "Vous etes sur de quiter?",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "NunitoBold",
            ),
          ),
        ],
      ),
      actions: [
        Negative(),
        Positive(() {
          exit(0);
        })
      ],
      blur: 2,
    ).show(context, transitionType: DialogTransitionType.Bubble);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidReturnButton,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/images/woman.png"),
                  ),
                ),
                title: Text(
                  "Bonjour Khouloud",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height,
                    width: double.infinity,
                    child: _image == null
                        ? Image.asset(
                            "assets/images/img.png",
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              floatingActionButtonLocation: floatingActionButtonLocation,
              floatingActionButton: _image == null
                  ? UploadImage(press: getImage)
                  : (done == false
                      ? UpdateImage(
                          validate: () {
                            setState(() {
                              done = true;
                              height = Constants.screenHeight * 0.4;
                              floatingActionButtonLocation = FloatingActionButtonLocation.miniEndDocked;
                            });
                          },
                          cancel: () {
                            deleteImage();
                          },
                        )
                      : edit()))),
    );
  }
}
