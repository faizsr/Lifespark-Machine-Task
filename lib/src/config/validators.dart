import 'package:lifespark_machine_task/src/config/regex_pattern.dart';

String? validateName(String? val) {
  if (val!.isEmpty) {
    return 'Required Field';
  } else if (val.length < 3) {
    return 'Please Enter A Valid Name';
  }
  return null;
}

String? validateEmail(String? val) {
  if (val!.isEmpty) {
    return 'Required Field';
  } else if (!RegExp(emailRegexPattern).hasMatch(val) || val.isEmpty) {
    return 'Enter A Valid Email';
  }
  return null;
}
