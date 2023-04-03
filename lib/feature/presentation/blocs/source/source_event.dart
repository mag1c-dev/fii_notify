part of 'source_bloc.dart';

abstract class SourceEvent extends Equatable {
  const SourceEvent();
}

class SourceLoadStarted extends SourceEvent {
  @override
  List<Object?> get props => [];

}


class NotifyReadSourceEvent extends SourceEvent {

  @override
  List<Object?> get props => [];

  const NotifyReadSourceEvent();
}
