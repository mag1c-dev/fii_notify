part of 'source_bloc.dart';

abstract class SourceState extends Equatable {
  const SourceState();
}

class SourceInitial extends SourceState {
  @override
  List<Object> get props => [];
}


class SourceLoading extends SourceState {
  @override
  List<Object> get props => [];
}



class SourceLoadSuccess extends SourceState {
  final List<Source>? sources;

  const SourceLoadSuccess({
    this.sources,
  });

  @override
  List<Object?> get props => [sources];


}


class SourceLoadError extends SourceState {
  final String error;

  const SourceLoadError({
    required this.error,
  });

  @override
  List<Object> get props => [error];

}
