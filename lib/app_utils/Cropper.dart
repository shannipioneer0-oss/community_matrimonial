


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Cropper{


  Future<String> getCroppedImage(String imagepath ,BuildContext context) async {


    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagepath,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    return croppedFile!.path;

  }




  Future<File> compressAndTryCatch(String path) async {
    Uint8List? result;

    try {
      result = await FlutterImageCompress.compressWithFile(
        path,
        format: CompressFormat.jpeg,
        quality: 50
      );



    } on UnsupportedError catch (e) {
      print(e);
      result = await FlutterImageCompress.compressWithFile(
        path,
        format: CompressFormat.jpeg,
      );
    }
    return await writeToFile(result!, path);
  }


  Future<File> writeToFile(List<int> image, String filePath) {
    return File(filePath).writeAsBytes(image, flush: true);
  }



}