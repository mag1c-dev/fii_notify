part of 'setting_bloc.dart';

class SettingState extends Equatable {
  final ThemeMode themeMode;




  @override
  // TODO: implement props
  List<Object?> get props => [themeMode];

  const SettingState({
    this.themeMode = ThemeMode.light,
  });

  SettingState copyWith({
    ThemeMode? themeMode,
  }) {
    return SettingState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
