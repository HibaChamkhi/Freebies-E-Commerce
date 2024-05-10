import 'package:flutter/cupertino.dart';

String? validateField(String value, String hintText) {
  if (value.trim().isEmpty) {
    return "$hintText cannot be empty.";
  }
  if (value.trim().length < 3 || value.trim().length > 30) {
    return "$hintText must be between 3 and 30 characters long.";
  }
  if (!value.trim().contains(RegExp(r'[a-zA-Z\u0600-\u06FF\s]+$')) ||
      value[0] == ' ') {
    return "Invalid ${hintText.toLowerCase()} value.";
  }
  if (value.trim().contains(RegExp(r'\d')) ||
      RegExp(r'[.,;!@#$%&*()_+=|<>?{}\[\]~-]').hasMatch(value.trim())) {
    return "$hintText must not contain special characters.";
  }
  return null;
}

String? validatePassword(
    String password, String hintText) {
  if (password.trim().isEmpty) {
    return "Password cannot be empty.";
  }
  if (password.trim().length < 8 || password.trim().length > 16) {
    return "$hintText must be between 8 and 16 characters long.";
  }

  if (!password.contains(RegExp(r'\d')) ||
      !password.contains(RegExp(r'[A-Z]')) ||
      !password.contains(RegExp(r'[a-z]')) ||
      !RegExp(r'[.!@#$%&*()_+=|<>?{}\[\]~-]').hasMatch(password.trim())) {
    return "Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character.";
  }
  return null;
}

String? validateEmail(String value) {
  // Regular expression for email validation
  final RegExp emailRegex = RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  // Remove spaces from the email
  String trimmedValue = value.trim();

  if (trimmedValue.isEmpty) {
    return "Please enter your email.";
  }
  if (!emailRegex.hasMatch(trimmedValue)) {
    return "Please enter a valid email address.";
  }

  return null; // Return null if email is valid
}
