import 'package:easy_localization/easy_localization.dart';
import 'package:europe_license_theory/app_theme_work/theme_textformfields.dart';
import 'package:europe_license_theory/app_theme_work/widgets_reusing.dart';
import 'package:europe_license_theory/feedback/service_feedback.dart';
import 'package:europe_license_theory/utilities/rest_api_utils.dart';
import 'package:flutter/material.dart';

class ScreenFeedback extends StatefulWidget {
  final String uuid;
  ScreenFeedback({required this.uuid});

  @override
  State<ScreenFeedback> createState() => _ScreenFeedbackState();
}

class _ScreenFeedbackState extends State<ScreenFeedback> {
  final titleController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("feedback.feedback".tr()),
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThemeTextFormFields.GetTextFormField(
                  "feedback.title".tr(), titleController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words),
              ThemeTextFormFields.GetTextFormField(
                  "feedback.email".tr(), emailController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none),
              ThemeTextFormFields.GetTextFormField(
                  "feedback.message".tr(), messageController,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences),
              WidgetsReusing.GetTextButton(context, "feedback.send".tr(), () {
                String title = titleController.text.toString();
                String email = emailController.text.toString();
                String message = messageController.text.toString();

                if (titleController.text.length < 3) {
                  WidgetsReusing.getSnakeBar(
                      context, "please_enter_valid_title".tr());
                  return;
                } else if (email.length < 6 &&
                    !email.contains("@") &&
                    !email.contains(".")) {
                  WidgetsReusing.getSnakeBar(
                      context, "please_enter_valid_email".tr());
                  return;
                } else if (message.length < 15) {
                  WidgetsReusing.getSnakeBar(
                      context, "sorry_message_short".tr());
                  return;
                }
                RestApiUtils.ShowLoadingDialog(context);
                ServiceFeedback.SendFeedback(
                        context, widget.uuid, title, email, message)
                    .then((value) {
                  Navigator.pop(context);
                  if (value.status == 200) {
                    WidgetsReusing.getSnakeBar(
                        context, "feedback_thank_message".tr());
                  } else {
                    WidgetsReusing.getSnakeBar(context, "${value.message}");
                    return;
                  }
                });
                titleController.text = '';
                emailController.text = '';
                messageController.text = '';
              }, EdgeInsets.symmetric(horizontal: 20, vertical: 20))
            ],
          ),
        ),
      ),
    );
  }
}
