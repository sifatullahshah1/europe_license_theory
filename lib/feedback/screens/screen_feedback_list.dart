// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// class ScreenFeedbackList extends StatefulWidget {
//   const ScreenFeedbackList({Key? key}) : super(key: key);
//
//   @override
//   State<ScreenFeedbackList> createState() => _ScreenFeedbackListState();
// }
//
// class _ScreenFeedbackListState extends State<ScreenFeedbackList> {
//   ModelSetting? modelSetting;
//   Box<String>? database_setting;
//
//   Future<ModelGetFeedback>? _future;
//
//   void LoadData(BuildContext context) {
//     try {
//       modelSetting = DatabaseSetting.getSettings(database_setting!);
//       modelSetting!.uuid;
//
//       setState(() {
//         _future = ServiceFeedback.GetFeedback(context, modelSetting!.uuid);
//       });
//     } catch (e) {
//       print("objectobject info_new_item : ${e.toString()}");
//       return;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     database_setting = Hive.box<String>(HiveUtils.database_setting);
//     // LoadData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     LoadData(context);
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () async {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//         title: Text("feedback.feedback".tr()),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               child: FutureBuilder(
//                 future: _future,
//                 builder: (context, AsyncSnapshot<ModelGetFeedback> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: RestApiUtils.ShowLoadingView(context),
//                     );
//                   } else if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError || snapshot.data!.status != 200) {
//                       return RestApiUtils.ShowErrorWithReloadView(
//                         context,
//                         snapshot.data!.message,
//                         AppAssets.internet_issue,
//                         isImageSVG: false,
//                         onPresseddd: () {
//                           LoadData(context);
//                         },
//                       );
//                     } else if (snapshot.hasData) {
//                       if (snapshot.data!.feedbackResponse != null &&
//                           snapshot.data!.feedbackResponse!.length > 0) {
//                         List<FeedbackResponse> list =
//                             snapshot.data!.feedbackResponse!;
//                         return Container(
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           child: ListView.separated(
//                             itemCount: list.length,
//                             itemBuilder: (context, index) {
//                               var item = list[index];
//
//                               return InkWell(
//                                 onTap: () {
//                                   if (item.isResponded!) {
//                                     showModalBottomSheet(
//                                         context: context,
//                                         builder: (BuildContext bc) {
//                                           return SheetFeedback(
//                                             feeback: item.feedback!,
//                                             response: item.response!,
//                                           );
//                                         });
//                                   }
//                                 },
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                             child: Text(
//                                           "${item.title}",
//                                           maxLines: 2,
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontFamily: ThemeTexts.Bold,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.black),
//                                         )),
//                                         Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20)),
//                                               color: item.isResponded!
//                                                   ? Colors.teal
//                                                   : Colors.orange,
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 item.isResponded!
//                                                     ? Icon(Icons.info_outline,
//                                                         color: Colors.white,
//                                                         size: 18)
//                                                     : Icon(
//                                                         Icons
//                                                             .check_circle_outline,
//                                                         color: Colors.white,
//                                                         size: 18),
//                                                 SizedBox(width: 5),
//                                                 item.isResponded!
//                                                     ? Container(
//                                                         width: 115,
//                                                         alignment:
//                                                             Alignment.center,
//                                                         child: Text(
//                                                           "Responded",
//                                                           style: TextStyle(
//                                                               fontSize: 13,
//                                                               fontFamily: ThemeTexts
//                                                                   .MediumItalic,
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       )
//                                                     : Container(
//                                                         width: 115,
//                                                         alignment:
//                                                             Alignment.center,
//                                                         child: Text(
//                                                           "Not Responded",
//                                                           style: TextStyle(
//                                                               fontSize: 13,
//                                                               fontFamily: ThemeTexts
//                                                                   .MediumItalic,
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       ),
//                                               ],
//                                             ))
//                                       ],
//                                     ),
//                                     Text(
//                                       "ticket: ${item.ticket}",
//                                       style: TextStyle(
//                                           fontSize: 13,
//                                           fontFamily: ThemeTexts.Medium,
//                                           color: ThemeColors.primary_dark_lt),
//                                     ),
//                                     SizedBox(height: 15),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                             child: Text(
//                                           "${item.feedback}",
//                                           style: TextStyle(
//                                               fontFamily: ThemeTexts.Medium,
//                                               fontSize: 16,
//                                               color: Colors.black),
//                                         )),
//                                         item.isResponded!
//                                             ? Icon(
//                                                 Icons.arrow_forward_ios,
//                                                 size: 18,
//                                                 color: Colors.grey,
//                                               )
//                                             : SizedBox()
//                                       ],
//                                     ),
//                                     SizedBox(height: 15),
//                                     Text(
//                                       "${ConstantFunctions.calendar_formate_now2.format(item.updatedAt!)}",
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                           fontFamily: ThemeTexts.SemiBold),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (context, index) {
//                               return Divider(height: 50);
//                             },
//                           ),
//                         );
//                       } else {
//                         return RestApiUtils.ShowEmptyBoxLoadView(
//                           context,
//                           path: AppAssets.invoice_not_found,
//                           title: "feedback.no_feedback_found".tr(),
//                         );
//                       }
//                     } else {
//                       return Center(
//                         child: RestApiUtils.ShowLoadingView(context),
//                       );
//                     }
//                   } else {
//                     return RestApiUtils.ShowEmptyBoxLoadView(
//                       context,
//                       path: AppAssets.invoice_not_found,
//                       title: "feedback.no_feedback_found".tr(),
//                     );
//                   }
//                 },
//               ),
//             ),
//             WidgetsReusing.GetTextButton(
//                 context, "feedback.write_feedback".tr(), () async {
//               await Navigator.push(
//                 context,
//                 ConstantFunctions.OpenNewActivity(
//                     ScreenFeedback(uuid: modelSetting!.uuid)),
//               );
//               LoadData(context);
//             }, EdgeInsets.symmetric(horizontal: 20, vertical: 35))
//           ],
//         ),
//       ),
//     );
//   }
// }
