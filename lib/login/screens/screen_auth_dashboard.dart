import 'package:europe_license_theory/login/screens/screen_verify_email.dart';
import 'package:europe_license_theory/login/screens/screen_verify_number.dart';
import 'package:flutter/material.dart';

import '../../app_theme_work/theme_texts.dart';
import '../../app_theme_work/widgets_reusing.dart';
import '../../utilities/constant_functions.dart';


class ScreenAuthDashboard extends StatefulWidget {
  const ScreenAuthDashboard({Key? key}) : super(key: key);

  @override
  State<ScreenAuthDashboard> createState() => _ScreenAuthDashboardState();
}

class _ScreenAuthDashboardState extends State<ScreenAuthDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to",
              style:ThemeTexts.textStyleTitle
            ),
            Text("Driving License Theory",
                style:ThemeTexts.textStyleSubTitle
            ),
            Padding(
              padding: const EdgeInsets.only( left: 15.0),
              child: Text("A place where you can practice all questions to succeed at the driver knowledge test",
                  style:ThemeTexts.textStyleSubTitle2
              ),
            ),
            SizedBox(height: 30,),
            Text("Let’s Get Started...",
                style:ThemeTexts.textStyleSubTitle2
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 20 , right: 20),
              child: WidgetsReusing.GetTextButtonfill(context,
                  "Continue with Phone Number", (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenVerifyNumber(),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),
                Padding(
               padding: EdgeInsets.only(left: 20 , right: 20),
               child: WidgetsReusing.GetTextButtonTransparent(context,
                " Continue with Email", (){
                   Navigator.of(context).push(
                     MaterialPageRoute(
                       builder: (context) => ScreenVerifyEmail(),
                     ),
                   );
                 }, ),
            ),



          ],
        )


    );
  }
}
