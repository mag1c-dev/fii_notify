part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomePageStarted extends HomeEvent {
  final User user;

  const HomePageStarted({required this.user});
}


class NotifyTypeSelected extends HomeEvent {
  final User user;
  final NotifyType? notifyType;

  const NotifyTypeSelected({
    required this.user,
    this.notifyType,
  });
}
