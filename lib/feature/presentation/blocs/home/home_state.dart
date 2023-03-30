part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Notify>? listNotify;
  final bool loading;
  final String? error;
  final int? counterNotify;
  final NotifyType notifyType;
  final Source? currentSource;

  @override
  List<Object?> get props => [
        listNotify,
        loading,
        error,
        counterNotify,
        notifyType,
    currentSource,
      ];

  const HomeState(
      {required this.notifyType,
      this.listNotify,
      this.loading = false,
      this.error,
      this.counterNotify,
      this.currentSource,
      });

  HomeState copyWith({
    List<Notify>? Function()? listNotify,
    bool? loading,
    String? error,
    int? counterNotify,
    NotifyType? notifyType,
    Source? Function()? currentSource,
  }) {
    return HomeState(
      listNotify: listNotify != null ? listNotify() : this.listNotify,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      counterNotify: counterNotify ?? this.counterNotify,
      notifyType: notifyType ?? this.notifyType,
      currentSource: currentSource!=null ? currentSource() : this.currentSource,
    );
  }
}
