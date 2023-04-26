part of 'check_update_bloc.dart';

abstract class CheckUpdateEvent extends Equatable {
  const CheckUpdateEvent();
}

class CheckUpdateStarted extends CheckUpdateEvent {


  final bool forceShowUpdate;
  @override
  List<Object?> get props => [forceShowUpdate];

  const CheckUpdateStarted({
    this.forceShowUpdate=false,
  });
}
