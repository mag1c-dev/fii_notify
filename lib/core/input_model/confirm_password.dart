import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError {
  mismatch('Xác nhận mật khẩu không khớp'),
  invalid('Hãy xác nhận mật khẩu');
  final String message;
  const ConfirmPasswordValidationError(this.message);
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
