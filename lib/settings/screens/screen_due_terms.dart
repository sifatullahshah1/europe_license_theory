import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_texts.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:flutter/material.dart';

class ScreenDueTerms extends StatefulWidget {
  const ScreenDueTerms({Key? key}) : super(key: key);

  @override
  State<ScreenDueTerms> createState() => _ScreenDueTermsState();
}

class _ScreenDueTermsState extends State<ScreenDueTerms> {
  int selected_index = 0;

  List<String> due_term_list = [
    "None",
    "Due on receipt",
    "Next Day",
    "2 days",
    "3 days",
    "4 days",
    "5 days",
    "6 days",
    "7 days",
    "10 days",
  ];
  List<String> due_term_value = [
    "0",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "10",
  ];
  void onSave() async {
    try {
      Navigator.pop(context, due_term_value[selected_index]);
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, "");
        return null!;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              Navigator.pop(context, "");
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text('setting.due_term'.tr()),
          /*actions: [
            InkWell(
              onTap: () async {
                try {
                  Navigator.pop(context, due_term_value[selected_index]);
                } catch (e) {
                  return;
                }
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 20, right: 20, bottom: 10, left: 10),
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 21, color: Colors.black87),
                ),
              ),
            ),
          ],*/
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: due_term_list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    selectedTileColor: Colors.blue[100],
                    selected: selected_index == index ? true : false,
                    // leading: selected_index == index ? Container() : SizedBox(),
                    onTap: () {
                      setState(() {
                        selected_index = index;
                      });
                    },
                    title: Text(
                      "${due_term_list[index]}",
                      style: ThemeTexts.textStyleSubTitle2.copyWith(
                        color: selected_index == index
                            ? Colors.black87
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: WidgetsReusing.GetTextButton(
                  context,
                  'setting.save'.tr(),
                  onSave,
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 30)),
            )
          ],
        ),
      ),
    );
  }
}
