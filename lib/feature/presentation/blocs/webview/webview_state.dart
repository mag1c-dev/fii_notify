part of 'webview_bloc.dart';

abstract class WebviewState extends Equatable {
  const WebviewState();
}

class WebviewInitial extends WebviewState {
  const WebviewInitial();

  @override
  List<Object> get props => [];
}

class WebviewLoadingToken extends WebviewState {
  const WebviewLoadingToken();

  @override
  List<Object> get props => [];
}

class WebviewLoadTokenSuccess extends WebviewState {
  const WebviewLoadTokenSuccess({
    required this.token,
    required this.url,
  });

  final Token token;
  final String url;

  @override
  List<Object> get props => [
        token,
        url,
      ];
}
