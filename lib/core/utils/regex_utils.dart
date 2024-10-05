class RegexUtils {
  static final RegExp _egyptPhoneNumberRegex =
      RegExp(r'^(010|011|012|015)\d{8}$');

  static bool checkPhone(String? phone) =>
      _egyptPhoneNumberRegex.hasMatch(phone!);
}
