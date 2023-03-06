import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoice/app_theme_work/theme_colors.dart';
import 'package:invoice/app_theme_work/theme_texts.dart';
import 'package:invoice/app_theme_work/widgets_reusing.dart';
import 'package:invoice/create_invoice/screen_business/screen_business_list.dart';
import 'package:invoice/dashboard/screens/screen_dashboard.dart';
import 'package:invoice/utilities/app_assets.dart';
import 'package:invoice/utilities/constant_functions.dart';

class ScreenOnboarding extends StatefulWidget {
  @override
  _ScreenOnboardingState createState() => _ScreenOnboardingState();
}

class _ScreenOnboardingState extends State<ScreenOnboarding> {
  int currentPage = 0;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  String title01 = "Create business invoice in one go!";
  String title02 = "Choose template";
  String title03 = "Generate invoice and share";

  String description01 = "Request a ride and be picked up on the same route by the driver";
  String description02 = "Publish a ride and pick up passengers along the way";
  String description03 = "Know where your drivers are ahead of time and view their current location on a map in real time";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setCurrentPage(value);
                },
                children: [
                  onBoardPage(AppAssets.board_01, title01, description01),
                  onBoardPage(AppAssets.board_02, title02, description02),
                  onBoardPage(AppAssets.board_03, title03, description03),
                ],
              ),
            ),
            // WidgetsReusing.GetTextButtonWithBackGround(
            //     context,
            //     "Login",
            //     openLgoinPage,
            //     EdgeInsets.symmetric(horizontal: 20, vertical: 30)),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              ),
            ),

            WidgetsReusing.GetTextButton(
              context,
              "Business Information",
              () async {
                await Navigator.push(
                    context,
                    ConstantFunctions.OpenNewActivity(ScreenBusinessList(
                      isFromInvoiceScreen: true,
                      isFromOnBoardingScreen: true,
                      is_purchased: false,
                    )));
              },
              EdgeInsets.only(top: 25),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      ConstantFunctions.OpenNewScreenClean(
                          context, ScreenDashboard());
                      ConstantFunctions.saveSharePrefModebool(
                          "is_show_board", true);
                    },
                    child: Container(
                      child: Text(
                        currentPage == 2 ? "finish" : "Skip",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                            fontFamily: ThemeTexts.Medium),
                      ),
                    ),
                  ),
                  /*Spacer(),
                  InkWell(
                    onTap: () {
                      if (currentPage < 2) {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInCubic);
                      } else {
                        ConstantFunctions.saveSharePrefModebool(
                            "is_show_board", true);

                        ConstantFunctions.OpenNewScreenClean(
                            context, ScreenDashboard());
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ThemeColors.primaryColor,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),*/
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
      padding: EdgeInsets.all(30),
      child: SvgPicture.asset(assetName),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 4.5),
        Container(
          height: MediaQuery.of(context).size.height * .30,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          // padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              // color: ThemeColors.primary_dark_lt,
              // image: svgIcon,
              ),
          child: svgIcon,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 19,
              fontFamily: ThemeTexts.SemiBold,
              fontWeight: FontWeight.w600,
              color: Colors.black87),
        ),
        // SizedBox(height: 10),
        // Expanded(
        //   child: Text(
        //     description,
        //     textAlign: TextAlign.center,
        //     style: TextStyle(fontSize: 14, color: Colors.black87),
        //   ),
        // )
      ],
    );
  }

  setCurrentPage(int value) {
    setState(() {
      if (currentPage == 2) {
        ConstantFunctions.saveSharePrefModebool("is_show_board", true);
      }
      currentPage = value;
    });
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 10 : 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        // borderRadius: BorderRadius.all(Radius.circular(5)),
        color:
            (currentPage == pageNo) ? ThemeColors.primaryColor : Colors.black12,
      ),
    );
  }
}
