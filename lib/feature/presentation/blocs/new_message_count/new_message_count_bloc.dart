import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/feature/domain/entities/notify.dart';
import 'package:fii_notify/feature/domain/usecases/get_notify_count_usecase.dart';
import 'package:fii_notify/injection_container.dart';

part 'new_message_count_event.dart';
part 'new_message_count_state.dart';

class NewMessageCountBloc extends Bloc<NewMessageCountEvent, NewMessageCountState> {
  NewMessageCountBloc() : super(const NewMessageCountState()) {
    on<NewMessageCountLoadRequested>(_onNewMessageCountLoadRequested);
  }

  final  _getNotifyCountUsecase = injector<GetNotifyCountUsecase>();
  FutureOr<void> _onNewMessageCountLoadRequested(NewMessageCountLoadRequested event, Emitter<NewMessageCountState> emit) async{
    try{
      final notify = await _getNotifyCountUsecase.call(GetNotifyCountUsecaseParams(notifyType: NotifyType.notice));
      final highlight = await _getNotifyCountUsecase.call(GetNotifyCountUsecaseParams( notifyType: NotifyType.highlight));
      final approval = await _getNotifyCountUsecase.call(GetNotifyCountUsecaseParams(notifyType: NotifyType.approval));
      emit(state.copyWith(approval: approval, highlight: highlight, notify: notify));
    }catch(_){
    }

  }
}
