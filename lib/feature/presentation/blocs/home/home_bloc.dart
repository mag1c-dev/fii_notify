import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/core/di_extension.dart';
import 'package:fii_notify/feature/domain/entities/source.dart';
import 'package:fii_notify/feature/domain/entities/user.dart';
import 'package:fii_notify/feature/domain/usecases/get_notify_list_usecase.dart';
import 'package:fii_notify/feature/domain/usecases/get_source_list_usecase.dart';
import 'package:fii_notify/injection_container.dart';

import '../../../domain/entities/notify.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(notifyType: NotifyType.all)) {
    on<HomePageStarted>(
      _onHomePageStarted,
    );
    on<NotifyTypeSelected>(
      _onNotifyTypeSelected,
    );
  }

  final _getNotifyListUsecase = injector<GetNotifyListUsecase>();

  FutureOr<void> _onHomePageStarted(
      HomePageStarted event, Emitter<HomeState> emit) async {
    add(NotifyTypeSelected(user: event.user, ));
  }

  FutureOr<void> _onNotifyTypeSelected(
      NotifyTypeSelected event, Emitter<HomeState> emit) async{
    try {

      emit(state.copyWith(loading: true, notifyType: event.notifyType,
      ));

      final notifies = await _getNotifyListUsecase
          .call(GetNotifyListUsecaseParams(user: event.user.username, notifyType: event.notifyType));

      emit(state.copyWith(
        listNotify: notifies,
        loading: false,
      ));
    } catch (error) {
      var message = '';
      if (error is DioError) {
        message = error.getDioMessage();
      }
      emit(
        state.copyWith(
          loading: false,
          error: message,
        ),
      );
    }
  }
}
