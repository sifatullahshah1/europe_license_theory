// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:in_app_review/in_app_review.dart';
// import 'package:intl/intl.dart';
// import 'package:invoice/app_theme_work/theme_colors.dart';
// import 'package:invoice/app_theme_work/theme_texts.dart';
// import 'package:invoice/app_theme_work/widgets_reusing.dart';
// import 'package:invoice/database_hive/database_setting.dart';
// import 'package:invoice/database_hive/hive_utils.dart';
// import 'package:invoice/feedback/screens/screen_feedback_list.dart';
// import 'package:invoice/login/models/model_country.dart';
// import 'package:invoice/login/screens/page_country_list.dart';
// import 'package:invoice/settings/model/model_setting.dart';
// import 'package:invoice/settings/screens/screen_date_formate.dart';
// import 'package:invoice/settings/screens/screen_number_formate.dart';
// import 'package:invoice/utilities/constant_functions.dart';
// import 'package:invoice/utilities/links_utils.dart';
//
// enum Availability { loading, available, unavailable }
//
// class ScreenSettings extends StatefulWidget {
//   const ScreenSettings({Key? key}) : super(key: key);
//
//   @override
//   State<ScreenSettings> createState() => _ScreenSettingsState();
// }
//
// class _ScreenSettingsState extends State<ScreenSettings> {
//   //============= Rating ==========================
//   final InAppReview _inAppReview = InAppReview.instance;
//   Availability _availability = Availability.loading;
//
//   Future<void> _requestReview() => _inAppReview.requestReview();
//
//   Future<void> _openStoreListing() => _inAppReview.openStoreListing(
//         appStoreId: LinksUtils.app_store_link,
//         microsoftStoreId: LinksUtils.play_store_link,
//       );
// //============= Rating ==========================
//
//   bool paidShowOnInvoice = true;
//
//   ModelSetting? modelSetting;
//
//   ModelCountry? modelCountry;
//   String due_term = "";
//   String number_formate_index = "3";
//   String number_formate_char = ",";
//   String date_formate = "";
//
//   onChangeFunction1(bool paidShowOnInvoice) {
//     setState(() {
//       this.paidShowOnInvoice = paidShowOnInvoice;
//     });
//   }
//
//   Box<String>? database_setting;
//
//   void LoadData() {
//     setState(() {
//       try {
//         modelSetting = DatabaseSetting.getSettings(database_setting!);
//         modelCountry = modelSetting!.modelCountry;
//         due_term = modelSetting!.due_term;
//         number_formate_index = modelSetting!.number_formate_index;
//         number_formate_char = modelSetting!.number_formate_char;
//         date_formate = modelSetting!.date_formate;
//       } catch (e) {
//         print("objectobject info_new_item : ${e.toString()}");
//         return;
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     database_setting = Hive.box<String>(HiveUtils.database_setting);
//     LoadData();
//     //============= Rating ==========================
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       try {
//         final isAvailable = await _inAppReview.isAvailable();
//         setState(() {
//           _availability = isAvailable && !Platform.isAndroid
//               ? Availability.available
//               : Availability.unavailable;
//         });
//       } catch (e) {
//         setState(() => _availability = Availability.unavailable);
//       }
//     });
//     //============= Rating ==========================
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     GestureTapCallback onTapShareApp = () {
//       _openStoreListing();
//     };
//     GestureTapCallback onTapRateUs = () {
//       _requestReview();
//     };
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         centerTitle: false,
//         leading: InkWell(
//           onTap: () async {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//         title: Text(
//           'setting.invoice_setting'.tr(),
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//         child: ListView(
//           children: [
//             SizedBox(height: 20),
//             // GetListTile('Due Terms', '$due_term', () async {
//             //   String new_due_term = await Navigator.push(
//             //       context, ConstantFunctions.OpenNewActivity(ScreenDueTerms()));
//             //
//             //   if (new_due_term != "") {
//             //     setState(() {
//             //       due_term = new_due_term;
//             //       modelSetting!.due_term = due_term;
//             //       DatabaseSetting.AddBusiness(modelSetting!, database_setting)
//             //           .then((value) {
//             //         if (value) {
//             //           WidgetsReusing.getSnakeBar(
//             //               context, "Setting updated successfully");
//             //         }
//             //       });
//             //     });
//             //   }
//             // }),
//             GetListTile('setting.default_currency'.tr(),
//                 '${modelCountry!.currency_code} ${modelCountry!.currency_symbol}',
//                 () async {
//               setCountryFromCountryPage();
//             }),
//             GetListTile(
//                 'setting.number_formate'.tr(),
//                 ConstantFunctions.NumberFormate(
//                     "1000000",
//                     int.parse(number_formate_index),
//                     "$number_formate_char"), () async {
//               Map<String, String> new_map = await Navigator.push(context,
//                   ConstantFunctions.OpenNewActivity(ScreenNumberFormate()));
//
//               if (new_map != null) {
//                 setState(() {
//                   number_formate_index = new_map["number_formate_index"]!;
//                   number_formate_char = new_map["number_formate_char"]!;
//
//                   modelSetting!.number_formate_index = number_formate_index;
//                   modelSetting!.number_formate_char = number_formate_char;
//                   DatabaseSetting.UpdateSettings(
//                           modelSetting!, database_setting)
//                       .then((value) {
//                     if (value) {
//                       WidgetsReusing.getSnakeBar(
//                           context, "setting_updated_successfully".tr());
//                     }
//                   });
//                 });
//               }
//             }),
//             GetListTile('setting.date_formate'.tr(),
//                 DateFormat(date_formate).format(DateTime.now()), () async {
//               String new_date_formate = await Navigator.push(context,
//                   ConstantFunctions.OpenNewActivity(ScreenDateFormate()));
//
//               if (new_date_formate != "") {
//                 setState(() {
//                   date_formate = new_date_formate;
//                   modelSetting!.date_formate = date_formate;
//
//                   DatabaseSetting.UpdateSettings(
//                           modelSetting!, database_setting)
//                       .then((value) {
//                     if (value) {
//                       WidgetsReusing.getSnakeBar(
//                           context, "Setting updated successfully");
//                     }
//                   });
//                 });
//               }
//             }),
//             GetListTile("feedback.feedback".tr(), '', () {
//               Navigator.push(context,
//                   ConstantFunctions.OpenNewActivity(ScreenFeedbackList()));
//             }),
//             /* GetListTile('setting.payment_method'.tr(), '', () {
//               Navigator.push(
//                   context,
//                   ConstantFunctions.OpenNewActivity(
//                       screenPaymentList(isFromInvoiceScreen: true)));
//             }),*/
//             GetListTile('setting.privacy_policy'.tr(), '', () {
//               ConstantFunctions.OpenUrlSite(
//                   context, LinksUtils.privacy_policy_url);
//             }),
//             GetListTile('setting.rate_us'.tr(), '', onTapRateUs),
//             GetListTile('setting.share_app'.tr(), '', onTapShareApp),
//
//             // GetSwitchTile(
//             //     'Paid Show on Invoice', paidShowOnInvoice, onChangeFunction1),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void setCountryFromCountryPage() async {
//     ModelCountry _modelCountry = await Navigator.of(context).push(
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 200),
//         pageBuilder: (context, animation, _) {
//           return FadeTransition(opacity: animation, child: PageCountryList());
//         },
//       ),
//     );
//
//     setState(() {
//       modelCountry = _modelCountry;
//       modelSetting!.modelCountry = _modelCountry;
//       DatabaseSetting.UpdateSettings(modelSetting!, database_setting)
//           .then((value) {
//         if (value) {
//           WidgetsReusing.getSnakeBar(
//               context, "setting_updated_successfully".tr());
//         }
//       });
//     });
//   }
//
//   Widget GetListTile(String title, String description, onTapp) {
//     return ListTile(
//       title: Text("$title", style: ThemeTexts.textStyleTitle2),
//       subtitle: Text("$description", style: ThemeTexts.textStyleTitle2),
//       onTap: onTapp,
//       trailing: Icon(Icons.arrow_forward_ios_rounded),
//     );
//   }
//
//   Widget GetSwitchTile(String title /*, String description*/, bool value,
//       Function onChangeMethod) {
//     return ListTile(
//       title: Text("$title"),
//       /*subtitle: Text("$description"),*/
//       trailing: CupertinoSwitch(
//         activeColor: ThemeColors.primaryColor,
//         trackColor: Colors.black38,
//         value: value,
//         onChanged: (bool newValue) {
//           onChangeMethod(newValue);
//         },
//       ),
//     );
//   }
// }
