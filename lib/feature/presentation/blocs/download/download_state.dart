part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();
}

class DownloadInitial extends DownloadState {
  @override
  List<Object> get props => [];
}

class DownloadInitialProgress extends DownloadState {
  const DownloadInitialProgress(this.app);

  final AppInformation app;

  @override
  List<Object> get props => [app];
}

class DownloadInProgress extends DownloadState {
  const DownloadInProgress(this.fileDownloads);

  final FileDownload fileDownloads;

  @override
  List<Object> get props => [fileDownloads];
}

class DownloadError extends DownloadState {
  const DownloadError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class DownloadSuccess extends DownloadState {
  const DownloadSuccess(this.fileDownload);

  final FileDownload fileDownload;

  @override
  List<Object> get props => [fileDownload];
}
