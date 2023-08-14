class FieldRegex {
  static RegExp defaultRegExp = RegExp(r'^[a-zA-Z0-9\s\p{P}]+$');
  static RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
  static RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');
  static RegExp emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  static RegExp dateRegExp =
      RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');
  static RegExp integerRegExp = RegExp(r'^[+-]?\d+$');
}
