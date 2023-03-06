import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:invoice/app_theme_work/widgets_reusing.dart';
import 'package:invoice/utilities/constant_functions.dart';

class ScreenNumberFormate extends StatefulWidget {
  const ScreenNumberFormate({Key? key}) : super(key: key);

  @override
  State<ScreenNumberFormate> createState() => _ScreenNumberFormateState();
}

class _ScreenNumberFormateState extends State<ScreenNumberFormate> {
  int selected_index = 0;

  // int.parse(number_formate_index),
  // "$number_formate_char"), () async {
  // Map<String, String> new_map

  Map<String, String> ssss = {
    "": "",
    "": "",
  };

  List<Map<String, String>> number_formate_list = [
    {
      "number_formate_index": "3",
      "number_formate_char": ",",
    },
    {
      "number_formate_index": "3",
      "number_formate_char": ".",
    },
    {
      "number_formate_index": "3",
      "number_formate_char": " ",
    },
    {
      "number_formate_index": "2",
      "number_formate_char": ",",
    },
    {
      "number_formate_index": "2",
      "number_formate_char": ".",
    },
  ];
  void onSave() async {
    try {
      Navigator.pop(context, number_formate_list[selected_index]);
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
            centerTitle: false,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context, "");
              },
              child: Icon(Icons.arrow_back),
            ),
            title: Text("setting.number_formate".tr()),
            /* actions: [
              InkWell(
                onTap: () async {
                  try {
                    Navigator.pop(context, number_formate_list[selected_index]);
                  } catch (e) {
                    return;
                  }
                },
                child: Padding(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: number_formate_list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
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
                        "${ConstantFunctions.NumberFormate("1000000", int.parse(number_formate_list[index]["number_formate_index"]!), number_formate_list[index]["number_formate_char"]!)}",
                        style: TextStyle(
                          color: selected_index == index
                              ? Colors.black
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
                    "setting.save".tr(),
                    onSave,
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30)),
              )
            ],
          ),
        ));
  }
}
