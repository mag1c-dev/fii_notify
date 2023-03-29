import 'package:formz/formz.dart';

enum CitizenCodeValidationError { empty }

class CitizenCode extends FormzInput<String, CitizenCodeValidationError> {
  const CitizenCode.pure() : super.pure('');

  const CitizenCode.dirty([super.value = '']) : super.dirty();

  @override
  CitizenCodeValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CitizenCodeValidationError.empty;
  }
}
