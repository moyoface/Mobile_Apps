class Validations {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Будь ласка, уведіть свій email';
    }

    // Basic email regex pattern
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Будь ласка, уведіть email правильно';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Будь ласка, уведіть свій username';
    }

    // Username regex pattern (alphanumeric and underscores, 3-16 characters)
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,16}$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username має мати від 3-16 символів та містити тільки літери, числа, та нижнє підкреснення';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Будь ласка, уведіть свій пароль';
    }
    if (value.length < 8) {
      return 'Пароль має містити щонайменше 8 символів';
    }
    if (value.length > 20) {
      return 'Пароль має містити не більше 20 символів';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Будь ласка, введіть своє ім\'я';
    }

    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Ім\'я може містити тільки літери';
    }

    return null;
  }
}
