import 'package:download_install_apk/download_install_apk.dart';
import 'package:fii_notify/feature/presentation/pages/splash/splash_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/device_utils.dart';
import 'core/utils/logger.dart';
import 'feature/presentation/blocs/authentication/authentication_bloc.dart';
import 'feature/presentation/blocs/check_update/check_update_bloc.dart';
import 'feature/presentation/blocs/download/download_bloc.dart';
import 'feature/presentation/blocs/setting/setting_bloc.dart';
import 'feature/presentation/pages/home/home.dart';
import 'feature/presentation/pages/login/login_page.dart';
import 'injection_container.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingBloc>(
          create: (context) => injector<SettingBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => injector<AuthenticationBloc>(),
        ),
        BlocProvider<CheckUpdateBloc>(
          create: (context) => injector<CheckUpdateBloc>()..add(const CheckUpdateStarted()),
        ),
        BlocProvider<DownloadBloc>(
          create: (context) => injector<DownloadBloc>(),
        ),
      ],
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.light(
              scheme: FlexScheme.brandBlue,
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              blendLevel: 9,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 8,
                blendOnColors: false,
                fabUseShape: true,
                fabSchemeColor: SchemeColor.primary,
                chipSchemeColor: SchemeColor.primaryContainer,
                chipSelectedSchemeColor: SchemeColor.primary,
                chipDeleteIconSchemeColor: SchemeColor.tertiary,
                inputDecoratorBorderType: FlexInputBorderType.underline,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,
            ),
            darkTheme: FlexThemeData.dark(
              scheme: FlexScheme.brandBlue,
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              blendLevel: 15,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 20,
                fabUseShape: true,
                fabSchemeColor: SchemeColor.primary,
                chipSchemeColor: SchemeColor.primaryContainer,
                chipSelectedSchemeColor: SchemeColor.primary,
                chipDeleteIconSchemeColor: SchemeColor.tertiary,
                inputDecoratorBorderType: FlexInputBorderType.underline,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,
            ),
            themeMode: themeState.themeMode,
            navigatorKey: _navigatorKey,
            builder: (context, child) {
              return MultiBlocListener(listeners: [
                BlocListener<CheckUpdateBloc, CheckUpdateState>(
                  listenWhen: (previous, current) => current is CheckUpdateSuccess,
                  listener: (context, state) async {
                    if (state is CheckUpdateSuccess) {
                      final module = state.module;
                      final lVer = int.parse(
                          (await DeviceUtils.getVersion()).replaceAll('.', ''));
                      final sVer = int.tryParse(
                          (module.version ?? '').replaceAll('.', '')) ??
                          0;
                      final sMinVer = int.tryParse(
                          (module.minVersion ?? '').replaceAll('.', '')) ??
                          0;
                      if ((state.forceShow || lVer < sVer) && context.mounted) {
                        await showDialog(
                          context: _navigator.context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: const Text('Cập nhật ứng dụng'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${module.appName} đã có phiên bản mới'),
                                Text('Mã phiên bản: ${module.version}'),
                                if (module.changeLogs != null)
                                  Text(module.changeLogs!),
                              ],
                            ),
                            actions: [
                              if (lVer > sMinVer)
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(_navigator.context).pop();
                                  },
                                  child: const Text('Để sau'),
                                ),
                              TextButton(
                                onPressed: () {
                                  _navigator.context
                                      .read<DownloadBloc>()
                                      .add(DownloadStarted(state.module));
                                },
                                child: const Text('Cập nhật'),
                              )
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
                BlocListener<CheckUpdateBloc, CheckUpdateState>(
                  listenWhen: (previous, current) => current is CheckUpdateError,
                  listener: (context, state) async {
                    if (state is CheckUpdateError) {
                      ScaffoldMessenger.of(_navigator.context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                ),

                BlocListener<DownloadBloc, DownloadState>(
                  listener: (context, state) {
                    if (state is DownloadInitialProgress) {
                      showDialog<void>(
                          barrierDismissible: false,
                          context: _navigator.context,
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<DownloadBloc>(),
                            child: AlertDialog(
                              title: Text(
                                '${state.app.appName}',
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                      'Vui lòng KHÔNG thoát khỏi ứng dụng trong tiến trình này!'),
                                  BlocConsumer<DownloadBloc, DownloadState>(
                                    listener: (context, state) {
                                      _navigator.pop();
                                    },
                                    listenWhen: (previous, current) =>
                                    current is DownloadSuccess ||
                                        current is DownloadError,
                                    builder: (context, state) {
                                      if (state is DownloadInProgress) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                value: state.fileDownloads
                                                    .downloaded /
                                                    state.fileDownloads.size,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8),
                                              child: Text(
                                                  '${(state.fileDownloads.downloaded * 100) ~/ state.fileDownloads.size}%'),
                                            ),
                                          ],
                                        );
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: BlocBuilder<DownloadBloc,
                                            DownloadState>(
                                          builder: (context, state) {
                                            if (state is DownloadInProgress) {
                                              return Text(
                                                'Đang tải xuống ${state.fileDownloads.name}',
                                                textAlign: TextAlign.left,
                                              );
                                            }
                                            return const Text('Đang khởi tạo');
                                          },
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<DownloadBloc>()
                                              .add(const DownloadCanceled());
                                        },
                                        child: const Text('Huỷ'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                    }
                    if (state is DownloadError) {
                      ScaffoldMessenger.of(_navigator.context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                    if (state is DownloadSuccess) {
                      DownloadInstallApk()
                          .install(
                        state.fileDownload.path,
                      )
                          .listen((event) {
                        logger.d(event);
                      });
                    }
                  },
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      // FirebaseService.registerNotify(
                      //     empNo: state.user.username!);
                      _navigator.pushAndRemoveUntil<void>(
                        Home.route(),
                            (_) => false,
                      );
                    } else if (state is AuthUnAuthenticated) {
                      _navigator.pushAndRemoveUntil<void>(
                        LoginPage.route(),
                            (_) => false,
                      );
                    }
                  },
                )
              ], child: child ?? const SplashPage(),);
            },
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}

