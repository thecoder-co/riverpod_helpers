extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.+]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.:;+=-?&])[A-Za-z\d@$!%*.?&]{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^\+?0[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }

  // capitalise first
  String get capitalizeFirst {
    if (length == 0) '';
    if (length == 1) return toUpperCase();
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension NullStringExtensions on String? {
  String? get capitalizeFirst {
    if (this == null) return null;
    if (this!.isEmpty) return '';
    if (this!.length == 1) return this!.toUpperCase();
    return "${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}";
  }
}
