import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../core/utils/logger.dart';
import '../../../domain/entities/token.dart';
import '../../blocs/webview/webview_bloc.dart';

class WebviewBody extends StatefulWidget {
  const WebviewBody({
    super.key,
  });

  @override
  State<WebviewBody> createState() => _WebviewBodyState();
}

class _WebviewBodyState extends State<WebviewBody> {
  InAppWebViewController? webController;

  final progressStream = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      webController?.reload();
    });
  }

  @override
  void dispose() {
    CookieManager.instance().deleteAllCookies();
    progressStream.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebviewBloc, WebviewState>(
      builder: (context, state) {
        if (state is WebviewLoadingToken) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is WebviewLoadTokenSuccess) {
          return FutureBuilder(
            future: _setCookie(Uri.parse(state.url), state.token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                logger.i('Webview loading url: ${state.url}');
                return WillPopScope(
                  onWillPop: () async {
                    if (await webController?.canGoBack() ?? false) {
                      await webController?.goBack();
                      return false;
                    } else {
                      return true;
                    }
                  },
                  child: SafeArea(
                    child: Scaffold(
                      body: Stack(
                        children: [
                          InAppWebView(
                            initialUrlRequest: URLRequest(
                              url: Uri.parse(state.url),
                            ),
                            initialOptions: InAppWebViewGroupOptions(
                              crossPlatform: InAppWebViewOptions(
                                useShouldOverrideUrlLoading: true,
                                allowFileAccessFromFileURLs: true,
                              ),
                              android: AndroidInAppWebViewOptions(
                                useHybridComposition: true,
                              ),
                              ios: IOSInAppWebViewOptions(
                                allowsInlineMediaPlayback: true,
                                sharedCookiesEnabled: true,
                              ),
                            ),
                            onWebViewCreated: (controller) {
                              webController = controller;
                            },
                            onProgressChanged: (controller, progress) {
                              progressStream.sink.add(progress);
                            },
                            onPageCommitVisible: (controller,
                                resource) async {},
                            onReceivedServerTrustAuthRequest:
                                (controller, challenge) async {
                              return ServerTrustAuthResponse(
                                action: ServerTrustAuthResponseAction.PROCEED,
                              );
                            },
                            onLoadStop: (webController, url) {
                              //_setCookie();
                            },
                          ),
                          StreamBuilder(
                            initialData: 0,
                            stream: progressStream.stream,
                            builder: (context, state) {
                              if (state.data == 100) {
                                return const SizedBox();
                              }
                              return Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: LinearProgressIndicator(
                                    value: (state.data??0) / 100,
                                    minHeight: 2.0,

                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        return Container();
      },
    );


  }

  Future<void> _setCookie(Uri uri, Token token) async {
    await CookieManager.instance().setCookie(
      url: uri,
      name: 'access_token',
      value: token.accessToken,
    );
    await CookieManager.instance().setCookie(
      url: uri,
      name: 'refresh_token',
      value: token.refreshToken ?? '',
    );
    await CookieManager.instance().setCookie(
      url: uri,
      name: 'expires_in',
      value: (token.expiresIn ?? 0).toString(),
    );
    await CookieManager.instance().setCookie(
      url: uri,
      name: 'token_type',
      value: token.tokenType ?? '',
    );
    await CookieManager.instance().setCookie(
      url: uri,
      name: 'scope',
      value: token.scope ?? '',
    );
  }
}
