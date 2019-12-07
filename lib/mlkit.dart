import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

File _image;

selecDialog(BuildContext context) {
  return containerForSheet<String>(
    context: context,
    child: CupertinoActionSheet(
      title: Text('사진을 선택해주세요.'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Album'),
          onPressed: () {
            Navigator.pop(context, 'Album');
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Camera'),
          onPressed: () {
            Navigator.pop(context, 'Camera');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context, "Cancel"),
      ),
    ),
  );
}

containerForSheet<String>({BuildContext context, Widget child}) {
  showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => child,
  ).then<void>((String value) {
    if (value == 'Camera') {
      _cameraMlKit();
    } else if (value == 'Album') {
      _albumMlKit();
    } else print("clicked ??");
  });
}

_cameraMlKit() async {
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  var _image = await ImagePicker.pickImage(source: ImageSource.camera);
  File image = _image;

  final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
  final VisionText visionText = await textRecognizer.processImage(visionImage);

  String text = visionText.text;
  print(text);

  textRecognizer.close();

//  for (TextBlock block in visionText.blocks) {
//    final Rect boundingBox = block.boundingBox;
//    final List<Offset> cornerPoints = block.cornerPoints;
//    final String text = block.text;
//    final List<RecognizedLanguage> languages = block.recognizedLanguages;
//
//    for (TextLine line in block.lines) {
//      // Same getters as TextBlock
//      for (TextElement element in line.elements) {
//        // Same getters as TextBlock
//      }
//    }
//  }
}

_albumMlKit() async {
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
  File image = _image;

  final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
  final VisionText visionText = await textRecognizer.processImage(visionImage);

  String text = visionText.text;
  print(text);

  textRecognizer.close();
}
