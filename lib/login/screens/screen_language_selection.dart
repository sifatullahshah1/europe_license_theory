import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:invoice/app_theme_work/theme_colors.dart';
import 'package:invoice/app_theme_work/theme_texts.dart';
import 'package:invoice/app_theme_work/widgets_reusing.dart';
import 'package:invoice/onboarding/screen_onboarding.dart';
import 'package:invoice/utilities/constant_functions.dart';
import 'package:invoice/utilities/language_controller.dart';

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
        title: WidgetsReusing.GetAppBarTitle("languages.select_language".tr()),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
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
          WidgetsReusing.GetTextButton(context, "languages.set_language".tr(),
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
              // Text(
              //   modelCountry.flag,
              //   style: TextStyle(fontSize: 30),
              // ),
              // SizedBox(
              //   width: 15,
              // ),
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
    ModelLanguage(
        name: "languages.arabic".tr(),
        flag: "🇦🇪",
        code_a: "ar",
        code_b: "AE"),
    ModelLanguage(
        name: "languages.danish".tr(),
        flag: "🇷🇺",
        code_a: "da",
        code_b: "DA"),
    ModelLanguage(
        name: "languages.german".tr(),
        flag: "🇷🇺",
        code_a: "de",
        code_b: "DE"),
    ModelLanguage(
        name: "languages.english".tr(),
        flag: "🇺🇸",
        code_a: "en",
        code_b: "US"),
    ModelLanguage(
        name: "languages.spanish".tr(),
        flag: "🇷🇺",
        code_a: "es",
        code_b: "ES"),
    ModelLanguage(
        name: "languages.estonian".tr(),
        flag: "🇪🇪",
        code_a: "et",
        code_b: "ET"),
    ModelLanguage(
        name: "languages.finnish".tr(),
        flag: "🇷🇺",
        code_a: "fi",
        code_b: "FI"),
    ModelLanguage(
        name: "languages.filipino".tr(),
        flag: "🇷🇺",
        code_a: "fil",
        code_b: "FIL"),
    ModelLanguage(
        name: "languages.french".tr(),
        flag: "🇷🇺",
        code_a: "fr",
        code_b: "FR"),
    ModelLanguage(
        name: "languages.french_canadian".tr(),
        flag: "🇷🇺",
        code_a: "frca",
        code_b: "CA"),
    ModelLanguage(
        name: "languages.indonesian".tr(),
        flag: "🇷🇺",
        code_a: "id",
        code_b: "ID"),
    ModelLanguage(
        name: "languages.italian".tr(),
        flag: "🇷🇺",
        code_a: "it",
        code_b: "IT"),
    ModelLanguage(
        name: "languages.korean".tr(),
        flag: "🇷🇺",
        code_a: "ko",
        code_b: "KO"),
    ModelLanguage(
        name: "languages.malayalam".tr(),
        flag: "🇷🇺",
        code_a: "ms",
        code_b: "MS"),
    ModelLanguage(
      name: "languages.dutch".tr(),
      flag: "🇷🇺",
      code_a: "nl",
      code_b: "NL",
    ),
    ModelLanguage(
      name: "languages.portuguese_br".tr(),
      flag: "🇷🇺",
      code_a: "pt",
      code_b: "BR",
    ),

    ModelLanguage(
      name: "languages.portuguese_pt".tr(),
      flag: "🇷🇺",
      code_a: "pt",
      code_b: "PT",
    ),

    ModelLanguage(
        name: "languages.russian".tr(),
        flag: "🇷🇺",
        code_a: "ru",
        code_b: "RU"), //
    ModelLanguage(
        name: "languages.swedish".tr(),
        flag: "🇷🇺",
        code_a: "sv",
        code_b: "SV"),
    ModelLanguage(
        name: "languages.thai".tr(), flag: "🇷🇺", code_a: "th", code_b: "TH",),
    ModelLanguage(
        name: "languages.turkish".tr(),
        flag: "🇷🇺",
        code_a: "tr",
        code_b: "TR"),
  ];
}
