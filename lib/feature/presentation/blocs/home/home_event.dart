part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomePageStarted extends HomeEvent {

  const HomePageStarted();
}


class HomePageLoadNotifyRequested extends HomeEvent {

  const HomePageLoadNotifyRequested();
}


class LoadMoreRequested extends HomeEvent {

  const LoadMoreRequested();
}


class NotifyTypeSelected extends HomeEvent {
  final NotifyType? notifyType;

  const NotifyTypeSelected({
    this.notifyType,
  });
}



class SourceSelectedHomeEvent extends HomeEvent {
  final Source? source;

  const SourceSelectedHomeEvent({
    this.source,
  });
}

class NotifyReadHomeEvent extends HomeEvent {
  final Notify notify;

  const NotifyReadHomeEvent({
    required this.notify,
  });
}



class RefreshedHomeEvent extends HomeEvent {

  const RefreshedHomeEvent();
}



