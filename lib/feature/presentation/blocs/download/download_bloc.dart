import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/core/extension/di_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/app_information.dart';
import '../../../domain/entities/file_download.dart';
import '../../../domain/usecases/cancel_download_usecase.dart';
import '../../../domain/usecases/download_usecase.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc()  :
        super(DownloadInitial()) {
    on<DownloadStarted>(_onDownloadStarted);
    on<DownloadCanceled>(_onDownloadCanceled);
  }

  final  _downloadUsecase = injector<DownloadUsecase>();
  final  _cancelDownloadUsecase = injector<CancelDownloadUsecase>();

  FutureOr<void> _onDownloadStarted(
    DownloadStarted event,
    Emitter<DownloadState> emit,
  ) async {
    try {
      if (event.app.androidDownloadURL == null) {
        throw Exception('Download url invalid');
      }

      final path = '${(await getExternalStorageDirectories(
            type: StorageDirectory.downloads,
          ))?[0].path ?? '/storage/emulated/0/Download'}/${event.app.appName}.apk';

      emit(DownloadInitialProgress(event.app));

      final downloadStream = _downloadUsecase.call(
        DownloadParams(
          url: event.app.androidDownloadURL!,
          savePath: path,
        ),
      );
      await emit.forEach(
        downloadStream.throttleTime(
          const Duration(milliseconds: 250),
          trailing: true,
        ),
        onData: (FileDownload data) {
          if (state is DownloadError) {
            return state;
          }
          if (data.status == DownloadStatus.success) {
            emit(DownloadSuccess(data));
          }
          return DownloadInProgress(data);
        },
        onError: (error, stackTrace) {
          return DownloadError('Download failure, error: $error');
        },
      );
    } catch (e) {
      if (e is DioError) {
        emit(DownloadError(e.getDioMessage()));
      } else {
        emit(DownloadError(e.toString()));
      }
    }
  }

  FutureOr<void> _onDownloadCanceled(
      DownloadCanceled event, Emitter<DownloadState> emit) {
    try {
      _cancelDownloadUsecase.call(NoParam());
      emit(const DownloadError('Download task has been cancel.'));
    } catch (_) {}
  }
}
