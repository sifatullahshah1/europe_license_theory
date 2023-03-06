import 'package:flutter/foundation.dart';

class ThemeNotifier extends ChangeNotifier {
  void updateTheme(bool isDarkModeOn) async {
    notifyListeners();
  }
}
