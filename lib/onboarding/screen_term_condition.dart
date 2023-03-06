import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/login/screens/screen_verify_number.dart';
import 'package:europe_license_theory/screen_dashboard.dart';
import 'package:europe_license_theory/utilities/app_assets.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:europe_license_theory/utilities/links_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class ScreenTermCondition extends StatefulWidget {
  @override
  _ScreenTermConditionState createState() => _ScreenTermConditionState();
}

class _ScreenTermConditionState extends State<ScreenTermCondition> {

  // ConstantFunctions.openLink(LinksUtils.privacy_policy_url);




  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.primary_dark_lt,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Load a Lottie file from your assets
            Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(AppAssets.app_icon,
                          width: 50, height: 50),
                      SizedBox(width: 10),
                      Text("tere", style: TextStyle(fontSize: 55, fontWeight: FontWeight.w500, color: Colors.white),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 10),
                  child: Text("terms_conditions.in_order_to_start_tere".tr(), style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center,),
                ),
                InkWell(
                  onTap: (){
                    ConstantFunctions.openLink(LinksUtils.privacy_policy_url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 40),
                    child: Text("terms_conditions.terms_conditions".tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white), textAlign: TextAlign.center,),
                  ),
                ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 InkWell(
                   onTap: (){
                     setState(() {
                       isChecked = !isChecked;
                     });
                   },
                   child: Container(
                     color: Colors.grey[200],
                     padding: EdgeInsets.all(17),
                     width: 65,
                     height: 65,
                     child: SvgPicture.asset(
                       isChecked ? AppAssets.checkbox_checked : AppAssets.checkbox_unchecked,
                       width: 30,
                       height: 30,
                     ),
                   ),
                 ),
                 InkWell(
                   onTap: (){
                     if(isChecked) {
                       openLgoinPage();
                     }
                   },
                   child: Container(
                     width: 180,
                     height: 65,
                     color: Colors.white,
                     alignment: Alignment.center,
                     padding: EdgeInsets.all(14),
                     child: Text(isChecked ? "terms_conditions.start".tr() : "terms_conditions.i_agree_term_and_condition".tr(), style: TextStyle(fontSize: isChecked ? 20 : 16,  fontWeight: isChecked ? FontWeight.w600 : FontWeight.w400, color: Colors.black), textAlign: TextAlign.center,),
                   ),
                 )
               ],
             )
              ],
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }




  void openLgoinPage() {
    ConstantFunctions.getSharePrefModebool("is_user_verified")
        .then((is_user_verified) async {
      if (is_user_verified) {
        ConstantFunctions.OpenNewScreenClean(context, ScreenDashboard());
      } else {
        await Navigator.push(context, ConstantFunctions.OpenNewActivity(ScreenVerifyNumber()));
        setState(() {
          isChecked = !isChecked;
        });
        // ConstantFunctions.OpenNewScreenClean(context, ScreenVerifyNumber());
      }
    });
  }
}

