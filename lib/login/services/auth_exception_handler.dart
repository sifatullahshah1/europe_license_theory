import 'package:easy_localization/easy_localization.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
  invalid_phone_number,
}

class AuthExceptionHandler {
  static generateExceptionMessage(String message) {
    String errorMessage;
    switch (message) {
      case "too-many-request":
        errorMessage = "verify_number.to_many_request".tr();
        break;
      case "invalid-phone-number":
        errorMessage = "verify_number.invalid_phone_number".tr();
        break;
      default:
        errorMessage = "verify_number.undefined_error".tr();
    }
    return errorMessage;
  }
}
