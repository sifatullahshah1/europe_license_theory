import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScreenDateFormate extends StatefulWidget {
  const ScreenDateFormate({Key? key}) : super(key: key);

  @override
  State<ScreenDateFormate> createState() => _ScreenDateFormateState();
}

class _ScreenDateFormateState extends State<ScreenDateFormate> {
  int selected_index = 0;

  List<String> date_formate_list = [
    'dd/MM/yyyy',
    'dd/MM/yy',
    'dd.MM.yyyy',
    'dd-MM-yyyy',
    'MM/dd/yyyy',
    'yyyy/MM/dd',
  ];

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
              Navigator.pop(context, date_formate_list[selected_index]);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text(
            'setting.date_formate'.tr(),
          ),
          actions: [
            // InkWell(
            //   onTap: () async {
            //     try {
            //       Navigator.pop(context, date_formate_list[selected_index]);
            //     } catch (e) {
            //       return;
            //     }
            //   },
            //   child: Padding(
            //     padding:
            //         EdgeInsets.only(top: 20, right: 20, bottom: 10, left: 10),
            //     child: Text(
            //       "Save",
            //       style: TextThemes.textStyleTitle2
            //           .copyWith(fontSize: 17, color: Colors.blue),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: date_formate_list.length,
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
                      "${DateFormat(date_formate_list[index]).format(DateTime.now())}",
                      style: TextStyle(
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
              child: WidgetsReusing.GetTextButton(context, 'setting.save'.tr(),
                  () {
                Navigator.pop(context, date_formate_list[selected_index]);
              }, const EdgeInsets.symmetric(horizontal: 30, vertical: 30)),
            )
          ],
        ),
      ),
    );
  }
}
