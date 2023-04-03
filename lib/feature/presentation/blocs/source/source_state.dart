part of 'source_bloc.dart';


enum SourceStatus {initialize, loading, error, success}
class SourceState extends Equatable {

  final SourceStatus status;
  final String? error;
  final List<Source>? sources;

  @override
  List<Object?> get props => [status, error, sources];

  const SourceState({
    required this.status,
    this.error,
    this.sources,
  });

  SourceState copyWith({
    SourceStatus? status,
    String? error,
    List<Source>? sources,
  }) {
    return SourceState(
      status: status ?? this.status,
      error: error ?? this.error,
      sources: sources ?? this.sources,
    );
  }
}
