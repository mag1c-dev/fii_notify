import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/token.dart';
import '../../../domain/usecases/get_token_usecase.dart';

part 'webview_event.dart';
part 'webview_state.dart';

class WebviewBloc extends Bloc<WebviewEvent, WebviewState> {
  WebviewBloc() : super(const WebviewInitial()) {
    on<WebviewStarted>(_onWebviewStarted);
  }

  final _getTokenUsecase = injector<GetTokenUsecase>();

  FutureOr<void> _onWebviewStarted(
      WebviewStarted event, Emitter<WebviewState> emit) async {
    emit(const WebviewLoadingToken());
    final token = await _getTokenUsecase.call(NoParam());
    emit(WebviewLoadTokenSuccess(token: token, url: event.url));
  }
}
