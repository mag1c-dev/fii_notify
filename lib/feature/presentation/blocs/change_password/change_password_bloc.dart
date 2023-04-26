import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/core/extension/di_extension.dart';
import 'package:formz/formz.dart';

import '../../../../core/input_model/confirm_password.dart';
import '../../../../core/input_model/password.dart';
import '../../../../core/input_model/username.dart';
import '../../../../injection_container.dart';
import '../../../domain/usecases/change_password_usecase.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(const ChangePasswordState()) {
    on<UsernameFieldChanged>(_onUsernameFieldChanged);
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
    on<OldPasswordFieldChanged>(_onOldPasswordFieldChanged);
    on<NewPasswordFieldChanged>(_onNewPasswordFieldChanged);
    on<ConfirmPasswordFieldChanged>(_onConfirmPasswordFieldChanged);
    on<ChangePasswordInit>(_onChangePasswordInit);
  }

  final _changePasswordUsecase = injector<ChangePasswordUsecase>();

  FutureOr<void> _onChangePasswordSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
    try {
      await _changePasswordUsecase.call(
        ChangePasswordParam(
          state.oldPassword.value,
          state.newPassword.value,
          username: state.authed ? null : state.username.value,
        ),
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
          error: message,
        ),
      );
    }
  }

  FutureOr<void> _onOldPasswordFieldChanged(
    OldPasswordFieldChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final oldPasswordField = Password.dirty(event.value);
    emit(
      state.copyWith(
        oldPassword: oldPasswordField,
        isValidated: Formz.validate(
          [
            oldPasswordField,
            state.newPassword,
            state.confirmPassword,
            if (!state.authed) state.username
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onNewPasswordFieldChanged(
    NewPasswordFieldChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final newPasswordField = Password.dirty(event.value);
    final confirmPasswordField = ConfirmPassword.dirty(
      value: state.confirmPassword.value,
      password: newPasswordField.value,
    );

    emit(
      state.copyWith(
        newPassword: newPasswordField,
        confirmPassword: confirmPasswordField,
        isValidated: Formz.validate(
          [
            state.oldPassword,
            newPasswordField,
            confirmPasswordField,
            if (!state.authed) state.username
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onConfirmPasswordFieldChanged(
    ConfirmPasswordFieldChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final confirmPasswordField = ConfirmPassword.dirty(
      value: event.value,
      password: state.newPassword.value,
    );

    emit(
      state.copyWith(
        confirmPassword: confirmPasswordField,
        isValidated: Formz.validate(
          [
            confirmPasswordField,
            state.oldPassword,
            state.newPassword,
            if (!state.authed) state.username
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onUsernameFieldChanged(
      UsernameFieldChanged event, Emitter<ChangePasswordState> emit) {
    final username = Username.dirty(
      event.value,
    );

    emit(
      state.copyWith(
        username: username,
        isValidated: Formz.validate(
          [
            username,
            state.oldPassword,
            state.newPassword,
            state.confirmPassword
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onChangePasswordInit(
      ChangePasswordInit event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        authed: event.authed, username: Username.dirty(event.username)));
  }
}
