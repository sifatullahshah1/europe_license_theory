import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/app_theme_work/theme_textformfields.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:europe_license_theory/login/services/service_auth.dart';
import 'package:europe_license_theory/screen_dashboard.dart';
import 'package:europe_license_theory/utilities/app_assets.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:europe_license_theory/utilities/image_helper.dart';
import 'package:europe_license_theory/utilities/image_utility.dart';
import 'package:europe_license_theory/utilities/rest_api_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ScreenSignup extends StatefulWidget {
  final String phone_number;
  final String fcm_token;
  ScreenSignup({required this.phone_number, required this.fcm_token});

  @override
  _ScreenSignupState createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final _nameController = TextEditingController();

  FocusNode name_focus_node = FocusNode();

  var text_title = "${"verify_number.complete_profile".tr()}";

  File? profile_image;
  String profile_name = "";
  final imagePicker = ImagePicker();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GestureTapCallback onTapVerify = () {
      if (profile_image == null) {
        WidgetsReusing.getSnakeBar(context, "Please select profile image");
      } else if (_nameController.text.length < 2) {
        WidgetsReusing.getSnakeBar(context, "Please enter valid name");
      } else {
        SingupFunction();
      }
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.transparent,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 60, left: 20),
                child: Text("$text_title",
                    style: ThemeTexts.textStyleTitle.copyWith(fontSize: 30)),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: (){
                  _openChangeImageBottomSheet();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 5, left: 20, right: 15, bottom: 5),
                  child: Hero(
                    tag: "Profile_image",
                    child: profile_image == null
                        ? image_placeholder
                        : Stack(
                          children: [
                            CircleAvatar(
                                backgroundImage: Image.file(profile_image!).image,
                                backgroundColor:
                                    ThemeColors.textformborder_color_lt,
                                radius: 60,
                              ),
                             Positioned(
                                 bottom: 1,
                                 right: 1,
                                 child: CircleAvatar(
                                   child: Icon(Icons.add_a_photo_outlined, size: 18, color: Colors.black),
                                   backgroundColor:
                                   Colors.grey[200],
                                   radius: 17,
                                 ),
                             )
                          ],
                        ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ThemeTextFormFields.GetTextFormField(
                  "", _nameController,
                  hint: "verify_number.full_name".tr(),
                  focusNode: name_focus_node,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0)),
              SizedBox(height: 30),
              WidgetsReusing.GetTextButton(
                  context,
                  "verify_number.done".tr(),
                  onTapVerify,
                  EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void SingupFunction() {
    String name = _nameController.text.toString();
    RestApiUtils.ShowLoadingDialog(context);
    ServiceAuth.SignUpFunction(
            widget.phone_number, "${widget.fcm_token}", "", name, profile_image)
        .then(
      (modelLogin) {
        Navigator.of(context).pop();
        if (modelLogin.status == 201) {
          // SharedPrefrenceUser.SaveUserData(modelLogin.modelUserData!);
          ConstantFunctions.saveSharePrefModeString(
              "bearerToken", modelLogin.bearerToken!);
          ConstantFunctions.saveSharePrefModebool("is_user_verified", true);

          ConstantFunctions.OpenNewScreenClean(context, ScreenDashboard());
        } else {
          WidgetsReusing.getSnakeBar(context, "${modelLogin.message}");
        }
      },
    );
  }

  Widget image_placeholder = SvgPicture.asset(
    AppAssets.image_onboard4,
    width: 120,
    height: 120,
  );




//======= Image Work ===========================

  _openChangeImageBottomSheet() {
    return showCupertinoModalPopup(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoActionSheet(
            title:  ImageHelper.GetSheetTitle(),
            actions: [
              ImageHelper.buildCupertinoActionSheetAction(
                icon: Icons.camera_alt,
                title: 'Camera',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.camera);
                },
              ),
              ImageHelper.buildCupertinoActionSheetAction(
                icon: Icons.photo_camera,
                title: 'Gallery',
                voidCallback: () async {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.gallery);
                },
              ),
              ImageHelper.buildCupertinoActionSheetAction(
                title: 'Cancel',
                voidCallback: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }


  _getImageFrom({required ImageSource source}) async {
    final _pickedImage = await imagePicker.pickImage(source: source,
      preferredCameraDevice: CameraDevice.front,
    );
    if (_pickedImage != null) {
      var image = File(_pickedImage.path.toString());
      final _sizeInKbBefore = image.lengthSync() / 1024;
      print('Before Compress $_sizeInKbBefore kb');
      var _compressedImage = await ImageHelper.compress(image: image);
      final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
      print('After Compress $_sizeInKbAfter kb');
      var _croppedImage = await ImageHelper.cropImage(_compressedImage);
      if (_croppedImage == null) {
        return;
      }
      setState(() {
        profile_image = _croppedImage;
        profile_name =
            ImageUtility.base64String(File(_croppedImage.path).readAsBytesSync());
      });

    }
  }


}
