import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fii_notify/core/di_extension.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/source.dart';
import '../../../domain/usecases/get_source_list_usecase.dart';

part 'source_event.dart';

part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  SourceBloc() : super(SourceInitial()) {
    on<SourceLoadStarted>(_onSourceLoadStarted);
  }

  final _getSourceListUsecase = injector<GetSourceListUsecase>();

  FutureOr<void> _onSourceLoadStarted(
      SourceLoadStarted event, Emitter<SourceState> emit) async {
    try {
      emit(SourceLoading());

      final sources = await _getSourceListUsecase.call(NoParam());

      emit(SourceLoadSuccess(sources: sources));
    } catch (error) {
      var message = '';
      if (error is DioError) {
        message = error.getDioMessage();
      }
      emit(SourceLoadError(error: message));
    }
  }
}
