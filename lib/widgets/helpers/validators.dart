class Validators {
  static bool isName(String? value) {
    return value!.isNotEmpty &&
        RegExp(r"^[\p{L} ,.'-]*$",
                caseSensitive: false, unicode: true, dotAll: true)
            .hasMatch(value);
  }

  static bool isEmail(String? value) {
    return value!.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);
  }

  static bool isPhone(String? value) {
    return value!.isNotEmpty &&
        RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value);
  }
}
