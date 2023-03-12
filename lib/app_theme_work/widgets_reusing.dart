import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetsReusing {
  static getSnakeBar(BuildContext context, String message,
      {GlobalKey<ScaffoldMessengerState>? scaffold}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0,
          duration: Duration(seconds: 4),
          content: Text(message, style: ThemeTexts.snakbar_text),
          backgroundColor: ThemeColors.snackbar_back_lt),
    );
  }

  //=========== Tab bar Work =========================================

  //=========== Tab bar Work =========================================

  static Widget getAddFloatingButton(
      String title, double widthh, GestureTapCallback onTapFloatingButton) {
    return InkWell(
      onTap: onTapFloatingButton,
      child: Container(
        height: 50,
        width: widthh,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: ThemeColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: Colors.white, size: 22),
            SizedBox(width: 5),
            Text(
              "$title",
              style: ThemeTexts.appbar_text_style.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  //============ Get Bottom Sheet =============================================


  static Future<Widget> GetBottomSheetGeneral(
      BuildContext context,
      String title,
      List<String> title_list,
      List<GestureTapCallback> on_tap_list,
      {String message = ""}) async {
    final action = CupertinoActionSheet(
      title: title != ""
          ? Text(
              title,
              style: ThemeTexts.textStyleValue,
            )
          : null,
      message: message != ""
          ? Text(message, style: ThemeTexts.textStyleValue)
          : null,
      // message: Text("Select a photo", style: TextStyle(fontSize: 15.0)),
      actions: title_list.asMap().keys.toList().map((index) {
        return getSheetItem(title_list[index], on_tap_list[index]);
      }).toList(),
      cancelButton: getSheetItem("show_invoices.cancel".tr(), () {
        Navigator.pop(context);
      }),
    );
    try {
      return await showCupertinoModalPopup(
          context: context, builder: (context) => action);
    }
    catch(e) {
      print("objectobjectobject ${e.toString()}");
      return SizedBox();
    }
  }

  static Widget getSheetItem(String title, onTap) {
    return CupertinoActionSheetAction(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          title,
          style: ThemeTexts.textStyleSubTitle2.copyWith(
            color: title == "bottomsheet.confirm_delete".tr() ||
                    title == "bottomsheet.delete".tr()
                ? Colors.red
                : Colors.blue,
          ),
        ),
      ),
      onPressed: onTap,
    );
  }

  static Widget getSheetItemCancel(context) {
    return WidgetsReusing.getSheetItem("Cancel", () {
      Navigator.pop(context);
    });
  }

  static Widget GetTextButton(context, String text, onTap, edgeinsets) {
    return Container(
      width: double.infinity,
      margin: edgeinsets,

      height: 57,
      color: ThemeColors.primaryColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(text, style: ThemeTexts.button_text_fill, textAlign: TextAlign.center,)),
      ),
    );
  }



  static Widget GetTextButtonUnderLine(context, String text, onTap, edgeinsets,
      {Color text_color = Colors.black87}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: edgeinsets,
        alignment: Alignment.center,
        height: 57,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black87, width: 1),
        //   borderRadius: BorderRadius.circular(0),
        // ),
        child: Text(
          text,
          style: ThemeTexts.button_text_transparent.copyWith(
            color: ThemeColors.primaryColor,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  static Widget GetTextButtonfill(
      context, String text, onTap, ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,

        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:  Color(0xFF222951),
            border: Border.all(
              // color: Theme.of(context).colorScheme.secondary,
              color: Colors.black87,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 50,
        child: Text(
          text,
          style: ThemeTexts.button_text_fill
          ),
        ),

    );
  }

  static Widget GetTextButtonTransparent(
      context, String text, onTap, ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,

        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              // color: Theme.of(context).colorScheme.secondary,
              color: Colors.black87,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 50,
        child: Text(
          text,
          style: ThemeTexts.button_text_transparent
        ),
      ),
    );
  }

  //========= Get Appbar Widgets ============================================

  static Widget GetAppBarActionText(String title, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 23, right: 5),
        child: Text("${title}", style: ThemeTexts.action_text_style),
      ),
    );
  }

  static Widget GetAppBarActionIcon(
      IconData icon_data, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 12, right: 10),
        child: Icon(icon_data, color: Colors.black87),
      ),
    );
  }

  static Widget GetAppBarActionWidget(
      Widget icon_data, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 12, right: 10),
        child: icon_data,
      ),
    );
  }

  static Widget GetAppbarLeading(GestureTapCallback onTap,
      {IconData iconData = Icons.arrow_back}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Icon(
          iconData,
          color: Colors.black87,
        ),
      ),
    );
  }

  static Widget GetAppBarTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Text("${title}", style: ThemeTexts.action_text_style),
    );
  }

//========= Get Appbar Widgets ============================================

}
