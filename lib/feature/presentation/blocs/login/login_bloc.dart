import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/core/extension/di_extension.dart';
import 'package:formz/formz.dart';

import '../../../../core/input_model/password.dart';
import '../../../../core/input_model/username.dart';
import '../../../../injection_container.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      :
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginPasswordVisibleToggle>(_onLoginPasswordVisibleToggle);
  }

  final  _loginUsecase = injector<LoginUsecase>();

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValidated: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValidated: Formz.validate([password, state.username]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValidated) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        await _loginUsecase.call(
          LoginParam(state.username.value, state.password.value),
        );
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (error) {
        var message = '';

        if (error is DioError) {
          message = error.getDioMessage();
        }

        emit(
          state.copyWith(
            submissionStatus: FormzSubmissionStatus.failure,
            errorMessage: message,
          ),
        );
      }
    }
  }

  FutureOr<void> _onLoginPasswordVisibleToggle(
      LoginPasswordVisibleToggle event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(showPassword: !state.showPassword),
    );
  }
}
