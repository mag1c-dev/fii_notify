part of 'notify_content_bloc.dart';

abstract class NotifyContentEvent extends Equatable {
  const NotifyContentEvent();
}

class NotifyContentPageStarted extends NotifyContentEvent {
  final Notify notify;

  const NotifyContentPageStarted({
    required this.notify,
  });

  @override
  List<Object?> get props => [notify];
}
