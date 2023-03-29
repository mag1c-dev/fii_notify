import 'package:fii_notify/feature/presentation/pages/home/home_page.dart';
import 'package:fii_notify/feature/presentation/pages/splash/splash_page.dart';
import 'package:fii_notify/firebase_service.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/presentation/blocs/authentication/authentication_bloc.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: FlexScheme.indigo,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 8,
          blendOnColors: false,
          inputDecoratorSchemeColor: SchemeColor.onTertiary,
          fabUseShape: true,
          fabSchemeColor: SchemeColor.primary,
          chipSchemeColor: SchemeColor.primaryContainer,
          chipSelectedSchemeColor: SchemeColor.primary,
          chipDeleteIconSchemeColor: SchemeColor.tertiary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.indigo,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          fabUseShape: true,
          fabSchemeColor: SchemeColor.primary,
          chipSchemeColor: SchemeColor.primaryContainer,
          chipSelectedSchemeColor: SchemeColor.primary,
          chipDeleteIconSchemeColor: SchemeColor.tertiary,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) => injector<AuthenticationBloc>(),
              )
            ],
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  FirebaseService.registerNotify(empNo: state.user.username!);
                  _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(),
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
            ));
      },
      home: const SplashPage(),
    );
  }
}
