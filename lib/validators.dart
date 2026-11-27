String? validateName(String? value) {

  final name = value?.trim() ?? '';
  if (name.isEmpty) return 'Please enter your name';
  if (name.length < 3) return 'Name must have at least 3 characters';
  return null;
}

//  validateEmail
String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return 'Please enter your email';
  final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!pattern.hasMatch(email)) return 'Enter a valid email address';
  return null;
}

// validatePhone
String? validatePhone(String? value) {
  final phone = value?.trim() ?? '';
  if (phone.isEmpty) return 'Please enter your phone number';
  if (!RegExp(r'^\d{10,11}$').hasMatch(phone)) {
    return 'Use 10 or 11 digits, numbers only';
  }
  return null;
}

//  validateCheckIn 
String? validateCheckIn(DateTime? date) {
  if (date == null) return 'Choose a check-in date';
  return null;
}

// validateAgreement (a checkbox is a bool)
String? validateAgreement(bool accepted) {
  if (!accepted) return 'Please accept the hotel policy';
  return null;
}