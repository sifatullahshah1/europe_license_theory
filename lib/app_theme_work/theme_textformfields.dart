import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:flutter/material.dart';

class ThemeTextFormFields {


  static final border_radius = BorderRadius.all(Radius.circular(5));
  static double border_width = 1;
  static var borderDecoration = OutlineInputBorder(
    borderRadius: border_radius,
    borderSide: const BorderSide(color: ThemeColors.editbox_color_grey, width: 0.91),
  );

  // Widget showEditText() {
  //   return Column(
  //     children: [
  //       ThemeTextFormFields.GetTextFormField("Message", myController,
  //           focusNode: null,
  //           keyboardType: TextInputType.number,
  //           textCapitalization: TextCapitalization.none,
  //
  //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0)),
  //       ThemeTextFormFields.GetTextFormField("Message", myController,
  //           focusNode: null,
  //           keyboardType: TextInputType.number,
  //           textCapitalization: TextCapitalization.none,
  //           maxLines: 5,
  //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0)),
  //     ],
  //   );
  // }

  static Widget GetTextFormField(
      String title, TextEditingController _controller,
      {keyboardType = TextInputType.text,
      String lable_text = "",
      bool isEnabled = true,
      FocusNode? focusNode,
      textCapitalization = TextCapitalization.sentences,
      maxLines = 1,
        textInputAction: TextInputAction.done,
        IconData? prefixIcon,
      padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      String hint = ""}) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != ""
              ? Text(title, style: ThemeTexts.textStyleTitle2)
              : SizedBox(),
          const SizedBox(height: 7),
          SizedBox(
            height: maxLines == 1 ? 60 : 165,
            child: TextFormField(
              focusNode: focusNode,
              textCapitalization: textCapitalization,
              controller: _controller,
              maxLines: maxLines,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              enabled: isEnabled,
              enableSuggestions: true,
              toolbarOptions: ToolbarOptions(
                  copy: true, cut: true, selectAll: true, paste: true),
              style: ThemeTexts.textStyleTitle2
                  .copyWith(color: ThemeColors.edit_textbox_color),
              keyboardType: keyboardType,
              decoration: InputDecoration(
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                labelText: "",
                suffixIcon: null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                hintText: hint,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: borderDecoration,
                enabledBorder: borderDecoration,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                errorStyle: ThemeTexts.textStyleTitle2,
                hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),
                labelStyle: ThemeTexts.textStyleTitle2,
                floatingLabelStyle: ThemeTexts.textStyleTitle2,
              ),
            ),
          ),
        ],
      ),
    );
  }


  //======= Simple for no border textformfield decoration =============

  static InputDecoration GetTextFormFieldDecorationOnlyBorder(hint_text) {
    return InputDecoration(
      hintText: hint_text,
      fillColor: Colors.transparent,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}
