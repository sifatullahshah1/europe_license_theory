import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:europe_license_theory/utilities/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ScreenDashboard extends StatefulWidget {
  @override
  _ScreenDashboardState createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);

  int tab_index = 0;
  List<String> tabList = ['First Tab', 'Second Tab', 'First Tab', 'Second Tab'];

  var selectedColor = ThemeColors.primaryColor;
  var unSelectedColor = Colors.black38;

  //=================In App Purchase ===================================

  bool is_purchased = false;


  int? groupValue = 0;


  //====================================================

  @override
  void initState() {
    super.initState();

    tabController.addListener(
      () {
        if (tabController.index == 0) {
          setState(() {
            tab_index = 0;
            tabController.index = tab_index;
          });
        } else if (tabController.index == 1) {
          setState(() {
            tab_index = 1;
            tabController.index = tab_index;
          });
        } else if (tabController.index == 2) {
          setState(() {
            tab_index = 2;
            tabController.index = tab_index;
          });
        } else if (tabController.index == 3) {
          setState(() {
            tab_index = 3;
            tabController.index = tab_index;
          });
        }
      },
    );


  }


  @override
  Widget build(BuildContext context) {
    var text_style = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontFamily: ThemeTexts.SemiBold);

    context.watch<LanguageController>();

    GestureTapCallback onCreateInvoice = () {

    };




    return SafeArea(
      top: false,
      right: false,
      left: false,
      bottom: true,
      child: WillPopScope(
        onWillPop: () {
          if (Platform.isAndroid) {
            if (tabController.index == 0) {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [
                        WidgetsReusing.getSheetItem(
                          "bottomsheet.close_app".tr(),
                          () {
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                      cancelButton: WidgetsReusing.getSheetItem(
                          "bottomsheet.cancel".tr(), () {
                        Navigator.pop(context);
                      }),
                    );
                  });
            } else {
              tab_index = 0;
              tabController.index = tab_index;
            }
          } else {
            exit(0);
          }
          return null!;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              // const SizedBox(height: 15.0),
              Expanded(
                child: DefaultTabController(
                  length: tabList.length,
                  child: Scaffold(
                    body: TabBarView(
                      controller: tabController,
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Container(
                            //Home screen
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Container(
                           //Progress screen
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Container(
                            //Exam Screen
                          )
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          // Will open menu
                          // child: ,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomAppBar(
              elevation: 0,
              shape: CircularNotchedRectangle(),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 75,
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        tab_index = 0;
                        tabController.index = tab_index;
                      },
                      // child: GetNavIcon(
                      //     AppAssets.home_icon, 0, "dashboard.home".tr()),
                    ),
                    InkWell(
                      onTap: () {
                        tab_index = 1;
                        tabController.index = tab_index;
                      },
                      // child: GetNavIcon(AppAssets.business_icon, 1,
                      //     "dashboard.business".tr()),
                    ),
                    InkWell(
                      onTap: () {
                        tab_index = 2;
                        tabController.index = tab_index;
                      },
                      // child: GetNavIcon(
                      //     AppAssets.client_icon, 2, "dashboard.customers".tr()),
                    ),
                    InkWell(
                      onTap: () {
                        tab_index = 3;
                        tabController.index = tab_index;
                      },
                      // child: GetNavIcon(
                      //     AppAssets.product_icon, 3, "dashboard.product".tr()),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget GetNavIcon(path, index, textTitle) {
    return Column(
      children: [
        SvgPicture.asset(
          path,
          width: 25,
          height: 25,
          color: tab_index == index ? selectedColor : unSelectedColor,
        ),
        SizedBox(height: 1),
        Text(
          textTitle,
          style: TextStyle(
              color: tab_index == index ? selectedColor : unSelectedColor,
              fontSize: 11,
              fontFamily: ThemeTexts.SemiBold),
        )
      ],
    );
  }

  PopupMenuItem GetPopupMenuItem(int value, String title) {
    return PopupMenuItem(
      child: Text("languages.$title".tr(), style: ThemeTexts.textStyleTitle),
      value: value,
    );
  }
}
//
// class ScreenShowInvoices extends StatefulWidget {
//   @override
//   _ScreenShowInvoicesState createState() => _ScreenShowInvoicesState();
// }
//
// class _ScreenShowInvoicesState extends State<ScreenShowInvoices> {
//   final textStyle = const TextStyle(
//     fontFamily: ThemeTexts.Bold,
//     fontSize: 12,
//     color: Colors.black,
//   );
//
//   int? groupValue = 0;
//
//   late Box<String> database_invoice;
//   List<ModelInvoice> list_invoice_all = [];
//   List<ModelInvoice> list_invoice = [];
//   List<String> tabsFilter = [];
//   int tab_Selected = 0;
//   final Widget svgBackground = SvgPicture.asset(
//     AppAssets.app_icon,
//   );
//   double unpaid = 0;
//   double overdue = 0;
//
//   void LoadData() {
//     list_invoice = DatabaseInvoice.getInvoiceList(database_invoice, groupValue);
//     list_invoice_all = DatabaseInvoice.getInvoiceList(database_invoice, 0);
//
//     unpaid = 0;
//     overdue = 0;
//     setState(() {
//       list_invoice_all.forEach((element) {
//         double total = element.payment_total;
//         double paid = element.modelPaymentReceived.amount;
//
//         print("dueDate is ${element.modelInvoiceInfo.due_date}");
//
//         DateTime currentDate = DateTime.now();
//         // DateTime dueDate = DateTime.parse(element.modelInvoiceInfo.due_date);
//
//         String dateStart = element.modelInvoiceInfo.due_date;
//         DateFormat inputFormat = DateFormat(element.modelSetting.date_formate);
//         // DateTime dueDate = inputFormat.parse("12-12-1992");
//         DateTime dueDate = inputFormat.parse(dateStart);
//
//         if (dueDate.compareTo(currentDate) < 0) {
//           print("dueDate is before currentDate");
//           overdue = overdue + (total - paid);
//         }
//
//         if (dueDate.compareTo(currentDate) > 0) {
//           print("dueDate is after currentDate");
//         }
//
//         unpaid = unpaid + (total - paid);
//       });
//     });
//   }
//
//   initState() {
//     super.initState();
//     database_invoice = Hive.box<String>(HiveUtils.database_invoice);
//     LoadData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//   }
// }
