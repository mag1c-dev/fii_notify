part of 'webview_bloc.dart';

abstract class WebviewEvent extends Equatable {
  const WebviewEvent();
}

class WebviewStarted extends WebviewEvent {
  const WebviewStarted({
    required this.url,
  });

  final String url;

  @override
  List<Object?> get props => [
        url,
      ];
}
