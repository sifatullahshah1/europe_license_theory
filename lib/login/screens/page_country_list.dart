import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_textformfields.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/utilities/constant_functions.dart';
import 'package:flutter/material.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            ConstantFunctions.saveSharePrefModeString("country_index", "0");
            Navigator.pop(context, ModelCountry.countries[0]);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: isSearching
            ? TextFormField(
                autofocus: true,
                style: ThemeTexts.appbar_text_style,
                decoration:
                    ThemeTextFormFields.GetTextFormFieldDecorationOnlyBorder(
                        "country_select.enter_country_name".tr()),
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
              )
            : Text("country_select.select_country".tr()),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                countries_filterd = ModelCountry.countries;
              });
            },
            icon: Icon(isSearching ? Icons.close : Icons.search),
          )
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
          height: 70,
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
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                child: Text(
                  modelCountry.currency_symbol,
                  style: TextStyle(fontSize: 18),
                ),
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
