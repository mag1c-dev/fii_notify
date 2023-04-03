part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Notify>? listNotify;
  final bool loading;
  final String? error;
  final int? counterNotify;
  final NotifyType notifyType;
  final Source? currentSource;
  final int loadPage;

  @override
  List<Object?> get props => [
        listNotify,
        loading,
        error,
        counterNotify,
        notifyType,
    currentSource,
    loadPage
      ];

  const HomeState(
      {required this.notifyType,
      this.listNotify,
      this.loading = false,
      this.error,
      this.counterNotify,
      this.currentSource,
        this.loadPage = 0,
      });

  HomeState copyWith({
    List<Notify>? Function()? listNotify,
    bool? loading,
    String? error,
    int? counterNotify,
    int? loadPage,
    NotifyType? notifyType,
    Source? Function()? currentSource,
  }) {
    return HomeState(
      listNotify: listNotify != null ? listNotify() : this.listNotify,
      loading: loading ?? this.loading,
      error: error,
      counterNotify: counterNotify ?? this.counterNotify,
      notifyType: notifyType ?? this.notifyType,
      currentSource: currentSource!=null ? currentSource() : this.currentSource,
      loadPage: loadPage ?? this.loadPage,
    );
  }
}
