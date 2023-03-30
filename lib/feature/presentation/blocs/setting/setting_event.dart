part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class ThemeModeSelected extends SettingEvent {
  final ThemeMode themeMode;


  @override
  List<Object?> get props => [themeMode];

  const ThemeModeSelected({
    required this.themeMode,
  });
}
