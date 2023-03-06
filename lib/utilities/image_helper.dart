import 'dart:io';

import 'package:europe_license_theory/utilities/image_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {

  static Future<File?> cropImage(File? imageFile) async {
    var _croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: const AndroidUiSettings(
          toolbarColor: Color(0xFF2564AF),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );

    return _croppedFile;
  }

  static Future<File> compress({
    required File image,
    int quality = 100,
    int percentage = 30,
  }) async {
    var path = await FlutterNativeImage.compressImage(image.absolute.path,
        quality: quality, percentage: percentage);
    return path;
  }

  static buildCupertinoActionSheetAction({
    IconData? icon,
    required String title,
    required VoidCallback voidCallback,
    Color? color,
  }) {
    return CupertinoActionSheetAction(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: Color(0xFF2564AF)),
            SizedBox(
              width: 120,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: title == "Cancel" ? Colors.red : const Color(0xFF2564AF),
                ),
              ),
            ),
            if (icon != null)
              const SizedBox(
                width: 25,
              ),
          ],
        ),
      ),
      onPressed: voidCallback,
    );
  }



  static GetSheetTitle() {
    return Text(
      'Change Image',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 19, backgroundColor: Colors.transparent, color: Colors.black87),
    );
  }



  //======= Image Work ===========================


  // InkWell(
  // onTap: (){
  // _openChangeImageBottomSheet();
  // },
  // child: Container(
  // padding: const EdgeInsets.only(
  // top: 5, left: 20, right: 15, bottom: 5),
  // child: Hero(
  // tag: "Profile_image",
  // child: profile_image == null
  // ? image_placeholder
  //     : Stack(
  // children: [
  // CircleAvatar(
  // backgroundImage: Image.file(profile_image!).image,
  // backgroundColor:
  // ThemeColors.textformborder_color_lt,
  // radius: 60,
  // ),
  // Positioned(
  // bottom: 1,
  // right: 1,
  // child: CircleAvatar(
  // child: Icon(Icons.add_a_photo_outlined, size: 18, color: Colors.black),
  // backgroundColor:
  // Colors.grey[200],
  // radius: 17,
  // ),
  // )
  // ],
  // ),
  // ),
  // ),
  // ),
  //

  // File? profile_image;
  // String profile_name = "";
  // final imagePicker = ImagePicker();


  // _openChangeImageBottomSheet() {
  //   return showCupertinoModalPopup(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return CupertinoActionSheet(
  //           title:  ImageHelper.GetSheetTitle(),
  //           actions: [
  //             ImageHelper.buildCupertinoActionSheetAction(
  //               icon: Icons.add_a_photo_outlined,
  //               title: 'Camera',
  //               voidCallback: () {
  //                 Navigator.pop(context);
  //                 _getImageFrom(source: ImageSource.camera);
  //               },
  //             ),
  //             ImageHelper.buildCupertinoActionSheetAction(
  //               icon: Icons.add_a_photo_outlined,
  //               title: title != "Signature" ? 'Gallery' : "Signature Pad",
  //               voidCallback: () async {
  //                 Navigator.pop(context);
  //
  //                 _getImageFrom(source: ImageSource.gallery);
  //
  //               },
  //             ),
  //             ImageHelper.buildCupertinoActionSheetAction(
  //               title: 'Cancel',
  //               voidCallback: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }
  //
  //
  //
  //
  //
  // _getImageFrom({required ImageSource source, required String title}) async {
  //   final _pickedImage = await imagePicker.pickImage(source: source);
  //   if (_pickedImage != null) {
  //     var image = File(_pickedImage.path.toString());
  //     final _sizeInKbBefore = image.lengthSync() / 1024;
  //     print('Before Compress $_sizeInKbBefore kb');
  //     var _compressedImage = await ImageHelper.compress(image: image);
  //     final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
  //     print('After Compress $_sizeInKbAfter kb');
  //     var _croppedImage = await ImageHelper.cropImage(_compressedImage);
  //     if (_croppedImage == null) {
  //       return;
  //     }
  //     setState(() {
  //       profile_image = _croppedImage;
  //       profile_name =
  //           ImageUtility.base64String(File(_croppedImage.path).readAsBytesSync());
  //     });
  //
  //   }
  // }

//======= Image Work ===========================


}