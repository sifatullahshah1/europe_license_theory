import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:invoice/app_theme_work/theme_texts.dart';

class SheetFeedback extends StatelessWidget {
  final String feeback;
  final String response;

  SheetFeedback({required this.feeback, required this.response});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "feedback.feedback".tr(),
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: ThemeTexts.SemiBold,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(left: 10, right: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${feeback}",
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: ThemeTexts.SemiBold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  "feedback.response".tr(),
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: ThemeTexts.SemiBold,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(left: 50, right: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  "${response}",
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: ThemeTexts.SemiBold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
