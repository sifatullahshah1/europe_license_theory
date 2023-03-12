import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/login/screens/screen_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../app_theme_work/theme_colors.dart';
import '../../app_theme_work/theme_textformfields.dart';
import '../../app_theme_work/theme_texts.dart';
import '../../app_theme_work/widgets_reusing.dart';
import '../../screen_dashboard.dart';
import '../../utilities/constant_functions.dart';
import '../../utilities/rest_api_utils.dart';
import '../services/SharedPrefrenceUser.dart';
import '../services/service_auth.dart';
class ScreenVerifyEmail extends StatefulWidget {
  const ScreenVerifyEmail({Key? key}) : super(key: key);

  @override
  State<ScreenVerifyEmail> createState() => _ScreenVerifyEmailState();
}

class _ScreenVerifyEmailState extends State<ScreenVerifyEmail> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool isVerificationCompleted = false;

  var text_title01 = "${"Hello"}";
  var text_title02 = "${"Enter email to start"}";
  FocusNode email_node = FocusNode();
  FocusNode code_node = FocusNode();
  bool isCodeSend = false;
  final bottom_side = BorderSide(
    color: Colors.grey[400]!,
    width: 1.8,
  );
  FirebaseAuth? auth;
  String? fcm_token = "";
  String? auth_token_id = "";
  late FirebaseMessaging firebaseMessaging;

  @override
  void initState() {
    super.initState();

    InitionalizeFirebase();
  }

  InitionalizeFirebase() async {
    try {
      email_node.requestFocus();
      firebaseMessaging = await FirebaseMessaging.instance;
      auth = await FirebaseAuth.instance;

      fcm_token = await firebaseMessaging.getToken(
          vapidKey: "BGpdLRs......"
      );
      setState(() {

      });
    } catch (e) {
      print('FirebaseUser e ${e}');
    }
  }

  Future<void> _signInAnonymously() async {
    try {
      RestApiUtils.ShowLoadingDialog(context);
      String email = "${_emailController.text.toString()}";
      if (isVerificationCompleted) {
        LoginFunction(email);
      }
      UserCredential userCredential = await auth!.signInAnonymously().then((userCredential) {
        auth!.currentUser!.getIdToken().then((auth_token_id) {
          this.auth_token_id = auth_token_id;
          LoginFunction(email);

        });
        return userCredential;
      });


      User? user = userCredential.user;
      print('Anonymous user ID: ${user!.uid}');
      if (userCredential.user != null) {
        int verificationCode = Random().nextInt(900000) + 100000;
        String verificationCodeString = verificationCode.toString();

        await userCredential.user!.sendEmailVerification(
          ActionCodeSettings(
            url: 'https://www.example.com/?code=$verificationCodeString',
            androidPackageName: 'com.example.myapp',
            iOSBundleId: 'com.example.myapp',
            handleCodeInApp: true,
          ),
          //   emailMessage: 'Your verification code for MyApp is: $verificationCodeString',
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Verification email has been sent to ${userCredential.user!
                    .email}. Please verify your email to continue.')));
      }
    } on FirebaseAuthException catch (e) {
      print('Anonymous sign-in failed: ${e.code} - ${e.message}');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: WidgetsReusing.GetAppbarLeading(
                () {
              Navigator.pop(context);
            }
        ),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Login",
                style:ThemeTexts.textStyleSubTitle
            ),
            Padding(
              padding: const EdgeInsets.only( left: 15.0),
              child: Text("Login now to track all your expenses and income at a place!",
                  style:ThemeTexts.textStyleSubTitle2
              ),
            ),
            SizedBox(height: 30,),
            Text("Email",
                style:ThemeTexts.textStyleSubTitle2
            ),
            SizedBox(height: 10,),
            ThemeTextFormFields.GetTextFormField(
              "", _emailController,
              hint: "Ex: abc@example.com".tr(),
              focusNode: email_node,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 20 , right: 20),
              child: WidgetsReusing.GetTextButtonfill(context,
                  "Verify", (){
                    _signInAnonymously();
                  }),
            ),




          ],
        )

    );
  }
  void LoginFunction(String email) {

    ServiceAuth.LoginFunction(email, "$fcm_token", this.auth_token_id!)
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
                  phone_number: email, fcm_token: fcm_token ?? ""));
        } else {
          // Navigator.of(context).pop();
          WidgetsReusing.getSnakeBar(context, "....${modelLogin.message}");
        }
      },
    );
  }
}
