part of 'check_update_bloc.dart';

abstract class CheckUpdateState extends Equatable {
  const CheckUpdateState();
}

class CheckUpdateInitial extends CheckUpdateState {
  @override
  List<Object> get props => [];
}

class CheckUpdateLoading extends CheckUpdateState {
  @override
  List<Object> get props => [];
}

class CheckUpdateSuccess extends CheckUpdateState {
  final AppInformation module;
  final bool forceShow;

  const CheckUpdateSuccess({
    required this.module,
    this.forceShow=false,
  });

  @override
  List<Object> get props => [module];


}

class CheckUpdateError extends CheckUpdateState {
  const CheckUpdateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
