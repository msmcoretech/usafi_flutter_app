class AppValidators {
  AppValidators._();

  /// ---------------- EMAIL ----------------
  static bool email(String value) {
    if (value.trim().isEmpty) return true;

    final regex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return !regex.hasMatch(value.trim());
  }

  /// ---------------- PHONE ----------------
  static bool phone(String value, {int length = 10}) {
    if (value.trim().isEmpty) return true;

    return !RegExp(r'^[0-9]+$').hasMatch(value) ||
        value.length != length;
  }

  /// ---------------- FULL NAME ----------------
  static bool fullName(String value) {
    if (value.trim().isEmpty) return true;

    return !RegExp(r'^[a-zA-Z ]+$').hasMatch(value) ||
        value.trim().length < 3;
  }

  /// ---------------- PASSWORD ----------------
  static bool password(String value, {int minLength = 8}) {
    if (value.isEmpty) return true;

    return value.length < minLength ||
        !RegExp(r'[A-Z]').hasMatch(value) ||
        !RegExp(r'[a-z]').hasMatch(value) ||
        !RegExp(r'[0-9]').hasMatch(value) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  }

  /// ---------------- CONFIRM PASSWORD ----------------
  static bool confirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return true;

    return password != confirmPassword;
  }

  static bool otp(String otp) {
    if (otp.isEmpty) return true;

    final otpRegex = RegExp(r'^\d{4}$');
    return !otpRegex.hasMatch(otp);
  }

}
