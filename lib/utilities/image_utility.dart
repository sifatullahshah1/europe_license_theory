import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageUtility {
  //Image from string
  // Image path_04 = ImageUtility.imageFromBase64String(modelData.path_04);

//String from image
//   String image_path01 = _image01 != null ? ImageUtility.base64String(File(_image01!.path).readAsBytesSync())

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
