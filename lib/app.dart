import 'package:fii_notify/feature/presentation/pages/splash/splash_page.dart';
import 'package:fii_notify/firebase_service.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/presentation/blocs/authentication/authentication_bloc.dart';
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
                inputDecoratorBackgroundAlpha: 0x1f,
                inputDecoratorSchemeColor: SchemeColor.primary,
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
                inputDecoratorBackgroundAlpha: 0x1f,
                inputDecoratorSchemeColor: SchemeColor.primary,),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,
            ),
            themeMode: themeState.themeMode,
            navigatorKey: _navigatorKey,
            builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
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
                child: child,
              );
            },
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
