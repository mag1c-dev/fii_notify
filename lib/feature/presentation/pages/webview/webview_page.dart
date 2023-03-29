import 'package:fii_notify/feature/presentation/pages/webview/webview_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/webview/webview_bloc.dart';

class WebviewPage extends StatelessWidget {
  const WebviewPage({
    super.key,
    required this.url,
    this.backButton = true,
    this.appName,
  });

  static Route<void> route({
    required String url,
    bool backButton = true,
    String? appName,
  }) {
    return MaterialPageRoute<void>(
        builder: (_) => WebviewPage(
              url: url,
              backButton: backButton,
              appName: appName,
            ));
  }

  final String url;
  final String? appName;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WebviewBloc()
        ..add(WebviewStarted(
          url: url,
        )),
      child: Scaffold(
        appBar: backButton
            ? AppBar(
                toolbarHeight: 40,
                title: Text(
                  appName ?? (Uri.parse(url).host),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                centerTitle: true,
                leading: TextButton(
                  child: const Text('Back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            : null,
        body: const WebviewBody(),
      ),
    );
  }
}
