class Validators {
  static String? email(String? v) {
    if (v == null || v.trim().isEmpty || !v.contains('@')) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.trim().length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  static String? username(String? v) {
    if (v == null || v.trim().length < 4) {
      return 'Username must be at least 4 characters.';
    }
    return null;
  }
}
