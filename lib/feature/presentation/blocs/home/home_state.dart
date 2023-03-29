part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Notify>? listNotify;
  final bool loading;
  final String? error;
  final int? counterNotify;
  final NotifyType notifyType;

  @override
  List<Object?> get props => [
        listNotify,
        loading,
        error,
        counterNotify,
        notifyType,
      ];

  const HomeState(
      {required this.notifyType,
      this.listNotify,
      this.loading = false,
      this.error,
      this.counterNotify});

  HomeState copyWith({
    List<Notify>? listNotify,
    bool? loading,
    String? error,
    int? counterNotify,
    NotifyType? notifyType,
  }) {
    return HomeState(
      listNotify: listNotify ?? this.listNotify,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      counterNotify: counterNotify ?? this.counterNotify,
      notifyType: notifyType ?? this.notifyType,
    );
  }
}
