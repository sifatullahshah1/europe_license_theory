import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/app_theme_work/theme_textformfields.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:europe_license_theory/login/models/model_country.dart';
import 'package:europe_license_theory/login/screens/page_country_list.dart';
import 'package:europe_license_theory/login/screens/screen_signup.dart';
import 'package:europe_license_theory/login/services/SharedPrefrenceUser.dart';
import 'package:europe_license_theory/login/services/auth_exception_handler.dart';
import 'package:europe_license_theory/login/services/service_auth.dart';
import 'package:europe_license_theory/screen_dashboard.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:europe_license_theory/utilities/rest_api_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class ScreenVerifyNumber extends StatefulWidget {
  const ScreenVerifyNumber({Key? key}) : super(key: key);

  @override
  _ScreenVerifyNumberState createState() => _ScreenVerifyNumberState();
}

class _ScreenVerifyNumberState extends State<ScreenVerifyNumber> {

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  var text_title01 = "${"Hello"}";
  var text_title02 = "${"Enter number to start"}";

  FocusNode phone_number_node = FocusNode();
  FocusNode code_node = FocusNode();


  bool isCodeSend = false;
  late ModelCountry modelCountry;

  final bottom_side = BorderSide(
    color: Colors.grey[400]!,
    width: 1.8,
  );

  FirebaseAuth? auth;
  String? verificationId;
  String? fcm_token = "";
  String? auth_token_id = "";
  late FirebaseMessaging firebaseMessaging;


  bool isVerificationCompleted = false;

  @override
  void initState() {
    super.initState();
    modelCountry = ModelCountry.countries[0];
    ModelCountry.SaveCountry(modelCountry);
    ConstantFunctions.saveSharePrefModeString("country_index", "0");
    InitionalizeFirebase();

  }


  InitionalizeFirebase() async {
    try {

       phone_number_node.requestFocus();
       firebaseMessaging = await FirebaseMessaging.instance;
       auth = await FirebaseAuth.instance;

       fcm_token = await firebaseMessaging.getToken(
           vapidKey: "BGpdLRs......"
       );
       setState(() {

       });

      // print('FirebaseUser fcm_token ${fcm_token}');
    } catch (e) {
      print('FirebaseUser e ${e}');
      // WidgetsReusing.getSnakeBar(context, "${e.toString()}");
    }
  }

  VerifyPhoneNumberFunction(context) async {
    try {
      RestApiUtils.ShowLoadingDialog(context);
      auth!.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: "${modelCountry.code}${_phoneController.text.toString()}",
        verificationCompleted: (PhoneAuthCredential credential) {
          setState(() {
            this.verificationId = credential.verificationId;
            _codeController.text = credential.smsCode.toString();
            isVerificationCompleted = true;
            PhoneVerificationCompleted();
          });
        },

        verificationFailed: (FirebaseException e) {
          Navigator.pop(context);

          WidgetsReusing.getSnakeBar(context,
              "${AuthExceptionHandler.generateExceptionMessage(e.message.toString())}");
        },
        codeSent: (String? verificationId, int? resendToken) {

          Navigator.pop(context);
          setState(() {
            this.verificationId = verificationId!;

            String message = "${"Enter OTP we have sent"} ${modelCountry.code}${_phoneController.text.toString()}";
            text_title01 = "Enter verification code";
            text_title02 = message;

            isCodeSend = true;
            code_node.requestFocus();
          });
        //  WidgetsReusing.getSnakeBar(context, message);
        },
        //autoRetrievedSmsCodeForTesting: "123123",
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );
    }
    on FirebaseException catch (e) {
      print('FirebaseUser Error-- ${e.code}');
      print('FirebaseUser Error-- ${e.message}');
      print(
          'FirebaseUser Error-- ${AuthExceptionHandler.generateExceptionMessage(e.code.toString())}');

      WidgetsReusing.getSnakeBar(context,
          "${AuthExceptionHandler.generateExceptionMessage(e.code.toString())}");
    }
  catch (e) {
      Navigator.of(context).pop();
      print('FirebaseUser error-e- ${e.toString()}');
      WidgetsReusing.getSnakeBar(context, "error ${e.toString()}}");
    }
  }

  @override
  Widget build(BuildContext context) {
    GestureTapCallback onTapVerify = () {
      if (!isCodeSend) {
        if (_phoneController.text.length < 6) {
          print('FirebaseUserError-- length < 6}');

          WidgetsReusing.getSnakeBar(
              context, "verify_number.invalid_phone_number".tr());
        } else {
          VerifyPhoneNumberFunction(context);
        }
      } else {
        PhoneVerificationCompleted();
      }
    };

    GestureTapCallback onTapBack = () {
      if (isCodeSend) {
        setState(() {
           text_title01 = "${"verify_number.hello".tr()}";
           text_title02 = "${"verify_number.enter_num_to_start".tr()}";

          isCodeSend = false;
          _codeController.text = "";
          phone_number_node.requestFocus();
        });
      } else {
        Navigator.pop(context);

      }
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: WidgetsReusing.GetAppbarLeading(onTapBack),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 60, top: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 60, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$text_title01",
                          style: ThemeTexts.textStyleTitle.copyWith(fontSize: 28)),
                      SizedBox(height: 10),
                      Text("$text_title02",
                          style: ThemeTexts.textStyleTitle.copyWith(fontSize: isCodeSend ? 20 : 20, fontWeight: FontWeight.w300, height: 1.4)),
                     ],
                  ),
                ),
                SizedBox(height: 25),
                isCodeSend
                    ? ThemeTextFormFields.GetTextFormField(
                         "", _codeController,
                        hint: "Enter code here".tr(),
                        focusNode: code_node,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.none,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),)
                    : getNumber(),
                SizedBox(height: 30),
                isCodeSend
                    ? Container(
                  padding: EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: onTapBack,
                        child: Text(
                          "Change phone number".tr(),
                          style: ThemeTexts.textStyleSubTitle2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.primary_dark_lt),
                        ),
                      ),
                    )
                    : SizedBox(),
                SizedBox(height: 10),
                WidgetsReusing.GetTextButton(
                    context,
                    isCodeSend ? "verify_number.verify".tr() : "verify_number.continue".tr(),
                    onTapVerify,
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20)),



              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getNumber() {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      // margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width / 1,
      // height: 75,
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              setCountryFromCountryPage();
            },
            child: Container(
              alignment: Alignment.center,
              height: 58,
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: ThemeColors.editbox_color_grey, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   width: 35,
                  //   height: 30,
                  //   margin: const EdgeInsets.only(bottom: 2.0, left: 0),
                  //   child: Text(
                  //     modelCountry.flag,
                  //     style: TextStyle(fontSize: 25),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                  // SizedBox(width: 8),
                  Text(modelCountry.code, style: ThemeTexts.textStyleSubTitle2),
                  SizedBox(width: 5),
                  Icon(Icons.keyboard_arrow_down_outlined,
                      color: ThemeColors.editbox_color_grey)
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: ThemeTextFormFields.GetTextFormField(
                "", _phoneController,
                hint: "verify_number.phone_number".tr(),
                focusNode: phone_number_node,
                keyboardType: TextInputType.phone,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1)),
          ),
        ],
      ),
    );
  }

  void setCountryFromCountryPage() async {
    ModelCountry _modelCountry = await Navigator.of(context)
        .push(ConstantFunctions.OpenNewActivity(PageCountryList()));

    setState(() {
      modelCountry = _modelCountry;
      ModelCountry.SaveCountry(modelCountry);
    });
  }

  //============= Verify number login function ================

  PhoneVerificationCompleted() {
    try {
      RestApiUtils.ShowLoadingDialog(context);
      String phone_number = "${modelCountry.code}${_phoneController.text.toString()}";
      if (isVerificationCompleted) {
        LoginFunction(phone_number);
      } else {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId!,
            smsCode: _codeController.text.toString());

        auth!.signInWithCredential(credential).then((UserCredential user) {
          auth!.currentUser!.getIdToken().then((auth_token_id) {
            this.auth_token_id = auth_token_id;

            LoginFunction(phone_number);

          });
        }).onError((error, stackTrace) {
          Navigator.pop(context);
          if (error.toString().contains("invalid-verification-code")) {
            String title01 = "${"verify_number.resend_verification_code".tr()} ${modelCountry.code}${_phoneController.text.toString()}";
            WidgetsReusing.getSnakeBar(context, title01);
            return;
          }

          WidgetsReusing.getSnakeBar(context, "${error.toString()}");
        }).timeout(Duration(seconds: 60));
      }
    } catch (e) {
      Navigator.of(context).pop();
      print("HelloFirebase : ${e.toString()}");
      WidgetsReusing.getSnakeBar(context, "e: ${e.toString()}");
    }
  }

  void LoginFunction(String phone_number) {
    SharedPrefrenceUser.SaveUserCountry(modelCountry);

    ServiceAuth.LoginFunction(phone_number, "$fcm_token", this.auth_token_id!)
        .then(
      (modelLogin) {
        Navigator.of(context).pop();

        if (modelLogin.status == 200) {
          SharedPrefrenceUser.SaveUserData(modelLogin.modelUserData!);
          ConstantFunctions.saveSharePrefModeString(
              "bearerToken", modelLogin.bearerToken!);
          ConstantFunctions.saveSharePrefModebool("is_user_verified", true);

          ConstantFunctions.OpenNewScreenClean(context, ScreenDashboard());

        } else if (modelLogin.status == 404) {
          ConstantFunctions.OpenNewScreenClean(
              context,
              ScreenSignup(
                  phone_number: phone_number, fcm_token: fcm_token ?? ""));
        } else {
          // Navigator.of(context).pop();
          WidgetsReusing.getSnakeBar(context, ".....${modelLogin.message}");
        }
      },
    );
  }
}








