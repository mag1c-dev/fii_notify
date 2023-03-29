part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {}

class AuthInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticated extends AuthenticationState {
  AuthAuthenticated(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

class AuthUnAuthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
