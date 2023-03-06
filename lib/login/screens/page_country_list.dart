import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing_app/app_theme_work/theme_colors.dart';
import 'package:ride_sharing_app/app_theme_work/theme_textformfields.dart';
import 'package:ride_sharing_app/app_theme_work/theme_texts.dart';
import 'package:ride_sharing_app/app_theme_work/widgets_reusing.dart';
import 'package:ride_sharing_app/utilities/constant_functions.dart';

import '../models/model_country.dart';

class PageCountryList extends StatefulWidget {
  const PageCountryList({Key? key}) : super(key: key);

  @override
  _PageCountryListState createState() => _PageCountryListState();
}

class _PageCountryListState extends State<PageCountryList> {
  List<ModelCountry> countries_filterd = [];

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      countries_filterd = ModelCountry.countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: AppBar(
        centerTitle: true,
        leading: WidgetsReusing.GetAppbarLeading(() {
          ConstantFunctions.saveSharePrefModeString("country_index", "0");
          Navigator.pop(context, ModelCountry.countries[0]);
        }),
        title: isSearching
            ? Padding(
                padding: EdgeInsets.only(left: 15, top: 15, right: 10),
                child: TextFormField(
                  autofocus: true,
                  style: ThemeTexts.appbar_text_style,
                  decoration:
                      ThemeTextFormFields.GetTextFormFieldDecorationOnlyBorder(
                          "verify_number.enter_country_name".tr()),
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    if (value.length > 0) {
                      countries_filterd = [];
                      ModelCountry.countries.forEach((country) {
                        if (country.name
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          countries_filterd.add(country);
                        }
                      });
                      setState(() {});
                    } else {
                      setState(() {
                        countries_filterd = ModelCountry.countries;
                      });
                    }
                  },
                ),
              )
            : WidgetsReusing.GetAppBarTitle(
                "country_select.select_country".tr()),
        actions: [
          WidgetsReusing.GetAppBarActionIcon(
              isSearching ? Icons.close : Icons.search, () {
            setState(() {
              isSearching = !isSearching;
              countries_filterd = ModelCountry.countries;
            });
          })
        ],
      ),
      body: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: countries_filterd.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  ConstantFunctions.saveSharePrefModeString(
                      "country_index", "$index");
                  Navigator.pop(context, countries_filterd[index]);
                },
                child: GetCard(countries_filterd[index]));
          }),
    );
  }

  Widget GetCard(ModelCountry modelCountry) {
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
                child:
                    Text(modelCountry.code, style: ThemeTexts.textStyleValue),
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
