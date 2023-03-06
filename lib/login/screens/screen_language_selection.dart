import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_colors.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:europe_license_theory/onboarding/screen_onboarding.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:europe_license_theory/utilities/language_controller.dart';
import 'package:flutter/material.dart';

class ScreenLanguageSelection extends StatefulWidget {
  final bool is_from_splash;
  ScreenLanguageSelection({required this.is_from_splash});

  @override
  _ScreenLanguageSelectionState createState() =>
      _ScreenLanguageSelectionState();
}

class _ScreenLanguageSelectionState extends State<ScreenLanguageSelection> {
  List<ModelLanguage> countries_filterd = [];

  bool isSearching = false;
  String code_a = "en";
  String code_b = "US";

  @override
  void initState() {
    super.initState();
    setState(() {
      countries_filterd = ModelLanguage.languages;
    });



  }

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {

    if(isFirstTime) {
    countries_filterd.forEach((element) {

    print("objectobjectobject ${element.code_a}");
    print("objectobjectobject ${context.locale.languageCode}");

    if(element.code_a == context.locale.languageCode) {
      code_a = element.code_a;
      code_b = element.code_b;
      }
    });
    isFirstTime = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.background,
      appBar: AppBar(
        centerTitle: false,
        leading: widget.is_from_splash
            ? SizedBox()
            : WidgetsReusing.GetAppbarLeading(() {
                Navigator.pop(context, true);
              }),
        title: WidgetsReusing.GetAppBarTitle("language.select_language".tr()),
        actions: [
          /* WidgetsReusing.GetAppBarActionIcon(
              isSearching ? Icons.close : Icons.search, () {
            setState(() {
              isSearching = !isSearching;
              countries_filterd = ModelLanguage.languages;
            });
          })*/
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          // isSearching
          //     ? AnimatedContainer(
          //         duration: Duration(seconds: 1),
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 15, top: 15, right: 10),
          //           child: TextFormField(
          //             autofocus: true,
          //             style: ThemeTexts.appbar_text_style,
          //             decoration: ThemeTextFormFields
          //                 .GetTextFormFieldDecorationOnlyBorder(
          //                     "verify_number.enter_country_name".tr()),
          //             textCapitalization: TextCapitalization.sentences,
          //             onChanged: (value) {
          //               if (value.length > 0) {
          //                 countries_filterd = [];
          //                 ModelLanguage.languages.forEach((country) {
          //                   if (country.name
          //                       .toLowerCase()
          //                       .contains(value.toLowerCase())) {
          //                     countries_filterd.add(country);
          //                   }
          //                 });
          //                 setState(() {});
          //               } else {
          //                 setState(() {
          //                   countries_filterd = ModelLanguage.languages;
          //                 });
          //               }
          //             },
          //           ),
          //         ),
          //       )
          //     : SizedBox(),
          Expanded(
            child: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: countries_filterd.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        code_a = countries_filterd[index].code_a;
                        code_b = countries_filterd[index].code_b;
                      });
                    },
                    child: GetCard(countries_filterd[index]));
              },
            ),
          ),
          WidgetsReusing.GetTextButton(context, "language.set_language".tr(),
              () {
            setState(() {
              context.setLocale(Locale('${code_a}', '${code_b}'));
              final vvvv = LanguageController();
              vvvv.notifyListeners();
            });
            if (widget.is_from_splash) {
              ConstantFunctions.OpenNewScreenClean(context, ScreenOnboarding());
            } else {
              Navigator.pop(context, true);
            }
          }, EdgeInsets.symmetric(horizontal: 20, vertical: 40))
        ],
      ),
    );
  }

  Widget GetCard(ModelLanguage modelCountry) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          height: 60,
          child: Row(
            children: [
              Text(
                modelCountry.flag,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  modelCountry.name,
                  style: ThemeTexts.textStyleTitle2,
                ),
              ),
              Container(
                child: code_a == modelCountry.code_a
                    ? CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.teal,
                        child: Icon(
                          Icons.done,
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black87,
          thickness: .4,
          height: 1,
        )
      ],
    );
  }
}

class ModelLanguage {
  String name;
  String flag;
  String code_a;
  String code_b;

  ModelLanguage(
      {required this.name,
      required this.flag,
      required this.code_a,
      required this.code_b});

  static List<ModelLanguage> languages = [
    ModelLanguage(name: "English", flag: "🇺🇸", code_a: "en", code_b: "US"),
    ModelLanguage(name: "Eesti", flag: "🇪🇪", code_a: "et", code_b: "ET"),
    ModelLanguage(name: "Россия", flag: "🇷🇺", code_a: "ru", code_b: "RU"),
    //   ModelLanguage(name: "Россия", flag: "🇷🇺", code_a: "ru", code_b: "RU"),
  ];
}
