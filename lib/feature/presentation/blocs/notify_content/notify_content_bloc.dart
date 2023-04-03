import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/core/di_extension.dart';
import 'package:fii_notify/core/utils/logger.dart';
import 'package:fii_notify/feature/domain/entities/notify_detail.dart';
import 'package:fii_notify/feature/domain/usecases/get_notify_detail_usecase.dart';
import 'package:fii_notify/injection_container.dart';

import '../../../domain/entities/notify.dart';

part 'notify_content_event.dart';
part 'notify_content_state.dart';

class NotifyContentBloc extends Bloc<NotifyContentEvent, NotifyContentState> {
  NotifyContentBloc() : super(const NotifyContentState(status: NotifyContentStatus.initialize)) {
    on<NotifyContentPageStarted>(_onNotifyContentPageStarted);
  }


  final _getNotifyDetailUsecase = injector<GetNotifyDetailUsecase>();
  FutureOr<void> _onNotifyContentPageStarted(NotifyContentPageStarted event, Emitter<NotifyContentState> emit) async {
    try {
      emit(state.copyWith(notify: event.notify, status: NotifyContentStatus.loading));
      final detail = await _getNotifyDetailUsecase.call(GetNotifyDetailUsecaseParams(id: event.notify.id!));
      emit(state.copyWith(status: NotifyContentStatus.success, notify: state.notify!.copyWith(read: true), notifyDetail: detail));
    } catch (error) {
      var message = '';
      if (error is DioError) {
        message = error.getDioMessage();
      }
      emit(
        state.copyWith(
          status: NotifyContentStatus.error,
          error: message,
        ),
      );
    }
  }
}
