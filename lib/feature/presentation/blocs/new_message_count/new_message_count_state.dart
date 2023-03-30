part of 'new_message_count_bloc.dart';


class NewMessageCountState extends Equatable {
  final int notify;
  final int highlight;
  final int approval;

  @override
  List<Object> get props => [notify, highlight, approval];

  const NewMessageCountState({
    this.notify=0,
    this.highlight=0,
    this.approval=0,
  });

  NewMessageCountState copyWith({
    int? notify,
    int? highlight,
    int? approval,
  }) {
    return NewMessageCountState(
      notify: notify ?? this.notify,
      highlight: highlight ?? this.highlight,
      approval: approval ?? this.approval,
    );
  }
}
