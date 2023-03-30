
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<ThemeModeSelected>(_onThemeModeSelected);
  }

  FutureOr<void> _onThemeModeSelected(ThemeModeSelected event, Emitter<SettingState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
