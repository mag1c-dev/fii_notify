part of 'new_message_count_bloc.dart';

abstract class NewMessageCountEvent extends Equatable {
  const NewMessageCountEvent();
}


class NewMessageCountLoadRequested extends NewMessageCountEvent {


  @override
  List<Object?> get props => [];

  const NewMessageCountLoadRequested();
}
