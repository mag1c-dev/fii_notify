part of 'new_message_count_bloc.dart';

abstract class NewMessageCountEvent extends Equatable {
  const NewMessageCountEvent();
}


class NewMessageCountLoadRequested extends NewMessageCountEvent {

  final String user;

  @override
  List<Object?> get props => [user];

  const NewMessageCountLoadRequested({
    required this.user,
  });
}
