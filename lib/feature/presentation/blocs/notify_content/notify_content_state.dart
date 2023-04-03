part of 'notify_content_bloc.dart';


enum NotifyContentStatus {initialize, loading, success, error}
class NotifyContentState extends Equatable {

  final NotifyContentStatus status;
  final Notify? notify;
  final NotifyDetail? notifyDetail;
  final String? error;


  @override
  List<Object?> get props => [status, notify, error, notifyDetail];

  const NotifyContentState({
    required this.status,
    this.notify,
    this.notifyDetail,
    this.error,
  });

  NotifyContentState copyWith({
    NotifyContentStatus? status,
    Notify? notify,
    NotifyDetail? notifyDetail,
    String? error,
  }) {
    return NotifyContentState(
      status: status ?? this.status,
      notify: notify ?? this.notify,
      notifyDetail: notifyDetail ?? this.notifyDetail,
      error: error,
    );
  }
}