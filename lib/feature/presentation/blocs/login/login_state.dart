part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.isValidated = false,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.errorMessage = '',
    this.showPassword = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool isValidated;
  final Username username;
  final Password password;
  final String errorMessage;
  final bool showPassword;
  final FormzSubmissionStatus submissionStatus;



  @override
  List<Object> get props =>
      [isValidated, username, password, errorMessage, showPassword, submissionStatus];

  LoginState copyWith({
    bool? isValidated,
    Username? username,
    Password? password,
    String? errorMessage,
    bool? showPassword,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return LoginState(
      isValidated: isValidated ?? this.isValidated,
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      showPassword: showPassword ?? this.showPassword,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }
}
