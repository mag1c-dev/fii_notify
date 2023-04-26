import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/core/extension/di_extension.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../../../../core/utils/device_utils.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/app_information.dart';
import '../../../domain/usecases/get_app_information_usecase.dart';


part 'check_update_event.dart';
part 'check_update_state.dart';

class CheckUpdateBloc extends Bloc<CheckUpdateEvent, CheckUpdateState> {
  CheckUpdateBloc() : super(CheckUpdateInitial()) {
    on<CheckUpdateStarted>(_onCheckUpdateStarted);
  }

  final _getModuleUsecase = injector<GetAppInformationUsecase>();

  FutureOr<void> _onCheckUpdateStarted(
      CheckUpdateStarted event, Emitter<CheckUpdateState> emit) async {
    emit(CheckUpdateLoading());
    try {
      final module = await _getModuleUsecase
          .call(GetAppInformationUsecaseParam(uuid: await PlatformDeviceId.getDeviceId, ipAddress: await DeviceUtils.getLocalIpAddress(), os: await DeviceUtils.getDeviceInfo(), version: event.forceShowUpdate?null:await DeviceUtils.getVersion(),));
      emit(CheckUpdateSuccess(module: module, forceShow: event.forceShowUpdate));
    } catch (e) {
      emit(CheckUpdateError(e is DioError ? e.getDioMessage() : e.toString()));
    }
  }
}
