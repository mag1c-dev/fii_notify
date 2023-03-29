import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError {
  invalid,
  mismatch,
}

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidationError.invalid;
    }
    return password == value ? null : ConfirmPasswordValidationError.mismatch;
  }
}

extension Explanation on ConfirmPasswordValidationError {
  String? get name {
    switch (this) {
      case ConfirmPasswordValidationError.mismatch:
        return 'Passwords must match';
      case ConfirmPasswordValidationError.invalid:
        return 'Confirm password can not empty';
    }
  }
}
