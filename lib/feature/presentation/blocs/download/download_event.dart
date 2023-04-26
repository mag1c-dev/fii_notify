part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();
}

class DownloadStarted extends DownloadEvent {
  const DownloadStarted(this.app);

  final AppInformation app;

  @override
  List<Object?> get props => [app];
}

class DownloadCanceled extends DownloadEvent {
  const DownloadCanceled();

  @override
  List<Object?> get props => [];
}
