part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.username = const Username.pure(),
    this.oldPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.isValidated = false,
    this.error,
    this.authed = false,
  });

  final Username username;
  final Password oldPassword;
  final Password newPassword;
  final ConfirmPassword confirmPassword;
  final String? error;
  final bool isValidated;
  final FormzSubmissionStatus submissionStatus;

  final bool authed;

  @override
  List<Object?> get props => [
        username,
        oldPassword,
        newPassword,
        confirmPassword,
        submissionStatus,
        isValidated,
        error,
        authed,
      ];

  ChangePasswordState copyWith({
    Username? username,
    Password? oldPassword,
    Password? newPassword,
    ConfirmPassword? confirmPassword,
    String? error,
    bool? isValidated,
    FormzSubmissionStatus? submissionStatus,
    bool? authed,
  }) {
    return ChangePasswordState(
      username: username ?? this.username,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error,
      isValidated: isValidated ?? this.isValidated,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      authed: authed ?? this.authed,
    );
  }
}
