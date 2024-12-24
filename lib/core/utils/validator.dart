class Validator {
  static String? validateEmpty(String value) {
    if (value.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

  static String? validateEmail(String email) {
    validateEmpty(email);
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String password) {
    validateEmpty(password);
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).+$');
    if (!passwordRegex.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }
}
