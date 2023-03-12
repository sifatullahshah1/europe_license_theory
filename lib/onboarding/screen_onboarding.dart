import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/login/screens/screen_verify_number.dart';
import 'package:europe_license_theory/onboarding/screen_term_condition.dart';
import 'package:europe_license_theory/screen_dashboard.dart';
import 'package:europe_license_theory/utilities/app_assets.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenOnboarding extends StatefulWidget {
  @override
  _ScreenOnboardingState createState() => _ScreenOnboardingState();
}

class _ScreenOnboardingState extends State<ScreenOnboarding> {
  int currentPage = 0;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setCurrentPage(value);
                },
                children: [
                  onBoardPage(
                      AppAssets.board_01,
                      "onbaording.title01".tr(),
                      "onbaording.description01".tr()),
                  onBoardPage(
                      AppAssets.board_02,
                      "onbaording.title02".tr(),
                      "onbaording.description02".tr()),
                  onBoardPage(
                      AppAssets.board_03,
                      "onbaording.title03".tr(),
                      "onbaording.description03".tr()),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 22),
              height: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentPage < 2 ? InkWell(
                    onTap: (){
                      ConstantFunctions.OpenNewScreenClean(context, ScreenTermCondition());
                    },
                    child: Text(
                      "onbaording.skip".tr(),
                      style: ThemeTexts.textStyleSubTitle2.copyWith(
                          letterSpacing: 0,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[400]),
                    ),
                  ) : SizedBox(),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      if (currentPage < 2) {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInCubic);
                      } else {
                        ConstantFunctions.saveSharePrefModebool(
                            "is_show_board", true);

                        ConstantFunctions.OpenNewScreenClean(context, ScreenTermCondition());
                        // openLgoinPage();
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: ThemeColors.primary_dark_lt,
                          child: Icon(Icons.arrow_forward,
                              color: Colors.white, size: 30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column onBoardPage(String assetName, String title, String description) {
    Widget svgIcon = Padding(
      padding: EdgeInsets.all(5),
      child: SvgPicture.asset(assetName),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Container(
          height: MediaQuery.of(context).size.height * .27,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              //   color: ThemeColors.primary_dark_lt,
              // image: svgIcon,
              ),
          child: svgIcon,
        ),
        SizedBox(height: 20),
        Text(title,
            textAlign: TextAlign.center, style: ThemeTexts.textStyleTitle),
        SizedBox(height: 10),
        SizedBox(
          child: Text(
            description,
            // textAlign: currentPage == 0 ? TextAlign.left : TextAlign.center,
            textAlign: TextAlign.center,
            style: ThemeTexts.textStyleTitle.copyWith(
                letterSpacing: 0,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff9E9DA2)),
          ),
        )
      ],
    );
  }

  setCurrentPage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 15 : 15,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.all(Radius.circular(5)),
        color: (currentPage == pageNo)
            ? ThemeColors.primary_dark_lt
            : Colors.grey[300],
      ),
    );
  }

  void openLgoinPage() {
    ConstantFunctions.getSharePrefModebool("is_user_verified")
        .then((is_user_verified) {
      if (is_user_verified) {
         ConstantFunctions.OpenNewScreenClean(context, ScreenDashboard());
      } else {
        ConstantFunctions.OpenNewScreenClean(context, ScreenVerifyNumber());
      }
    });
  }
}
