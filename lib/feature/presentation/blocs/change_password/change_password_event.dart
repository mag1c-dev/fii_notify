part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class ChangePasswordInit extends ChangePasswordEvent {
  const ChangePasswordInit({this.authed = false, this.username = ''});

  final bool authed;
  final String username;
  @override
  List<Object> get props => [authed, username];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  const ChangePasswordSubmitted();
}

class OldPasswordFieldChanged extends ChangePasswordEvent {
  const OldPasswordFieldChanged(this.value);

  final String value;
}

class NewPasswordFieldChanged extends ChangePasswordEvent {
  const NewPasswordFieldChanged(this.value);

  final String value;
}

class ConfirmPasswordFieldChanged extends ChangePasswordEvent {
  const ConfirmPasswordFieldChanged(this.value);

  final String value;
}

class UsernameFieldChanged extends ChangePasswordEvent {
  const UsernameFieldChanged(this.value);

  final String value;
}
