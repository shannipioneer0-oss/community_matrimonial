

import 'dart:io';

import 'package:community_matrimonial/app_utils/Cropper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerWithCrop{

  final void Function(String) callbackFunction;

  ImagePickerWithCrop({required this.callbackFunction});


  void selectImage(BuildContext context){


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Get Image",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Select Image from Gallery or capture from Camera"),
                SizedBox(height: 20),

                /// CAMERA
                ListTile(
                  leading: Icon(Icons.camera, color: Colors.pink),
                  title: Text("Camera"),
                  onTap: () async {
                    Navigator.of(context).pop();

                    final file = await _pickImage(ImageSource.camera);
                    Directory? externalDir = await getExternalStorageDirectory();

                    if (file.lengthSync() != 0) {
                      String imagePath =
                          '${externalDir!.path}/picked_image_${DateTime.now().millisecondsSinceEpoch}.jpeg';

                      File newImage = File(imagePath);
                      List<int> imageBytes = await file.readAsBytes();
                      await newImage.writeAsBytes(imageBytes);

                      final filepath =
                      await Cropper().getCroppedImage(newImage.absolute.path, context);

                      if (filepath != null) {
                        final filecompressed =
                        await Cropper().compressAndTryCatch(filepath);

                        String imagePath2 =
                            '${externalDir.path}/picked_image_${DateTime.now().millisecondsSinceEpoch}.jpeg';

                        File newImage2 = File(imagePath2);
                        List<int> imageBytes2 =
                        await filecompressed.readAsBytes();
                        await newImage2.writeAsBytes(imageBytes2);

                        callbackFunction(newImage2.absolute.path);
                      }
                    }
                  },
                ),

                /// GALLERY
                ListTile(
                  leading: Icon(Icons.image, color: Colors.red),
                  title: Text("Gallery"),
                  onTap: () async {
                    Navigator.of(context).pop();

                    final file = await _pickImage(ImageSource.gallery);
                    Directory? externalDir = await getExternalStorageDirectory();

                    if (file.lengthSync() != 0) {
                      String imagePath =
                          '${externalDir!.path}/picked_image_${DateTime.now().millisecondsSinceEpoch}.jpeg';

                      File newImage = File(imagePath);
                      List<int> imageBytes = await file.readAsBytes();
                      await newImage.writeAsBytes(imageBytes);

                      final filepath =
                      await Cropper().getCroppedImage(newImage.absolute.path, context);

                      if (filepath != null) {
                        final filecompressed =
                        await Cropper().compressAndTryCatch(filepath);

                        String imagePath2 =
                            '${externalDir.path}/picked_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

                        File newImage2 = File(imagePath2);
                        List<int> imageBytes2 =
                        await filecompressed.readAsBytes();
                        await newImage2.writeAsBytes(imageBytes2);

                        callbackFunction(newImage2.absolute.path);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );





  }



  Future<File> _pickImage( ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);


    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return File("");
  }



}