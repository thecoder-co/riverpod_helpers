extension Validators on String {
  bool get isEmail {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.+]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(this);
  }

  bool get isPassword {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=\S+$).{8,}$',
    );
    return passwordRegex.hasMatch(this);
  }
}

class Validator {
  final List<String? Function(String)> _validators = [];

  Validator addValidator(bool Function(String) condition, String message) {
    _validators.add((String value) {
      if (!condition(value)) {
        return message;
      }
      return null;
    });
    return this;
  }

  String? validate(String? value) {
    for (final validator in _validators) {
      final error = validator(value ?? '');
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  // Reusable validation methods
  Validator isEmail([String message = 'Invalid email']) {
    return addValidator((value) => value.isEmail, message);
  }

  Validator isFullName(
      [String message = 'Please enter your full name, separated by a space']) {
    return addValidator((value) => value.split(' ').length >= 2, message);
  }

  Validator isPassword(
      [String message =
          'Password must be at least 8 characters and contain at least one letter and one number']) {
    return addValidator((value) => value.isPassword, message);
  }

  Validator isNotEmpty([String message = 'This field is required']) {
    return addValidator((value) => value.isNotEmpty, message);
  }

  Validator isNumber([String message = 'This field must be a number']) {
    return addValidator((value) => int.tryParse(value) != null, message);
  }

  Validator minLength(int length, [String? message]) {
    return addValidator((value) => value.length >= length,
        message ?? 'This field must be at least $length characters');
  }

  Validator custom(bool Function(String) condition, String message) {
    return addValidator(condition, message);
  }
}
