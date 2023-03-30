import 'package:fii_notify/feature/presentation/blocs/home/home_bloc.dart';
import 'package:fii_notify/feature/presentation/blocs/new_message_count/new_message_count_bloc.dart';
import 'package:fii_notify/feature/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/source/source_bloc.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Home());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(HomePageStarted(user: (context.read<AuthenticationBloc>().state as AuthAuthenticated).user)),
        ),
        BlocProvider<SourceBloc>(
          create: (context) => SourceBloc()..add(SourceLoadStarted()),
        ),
        BlocProvider<NewMessageCountBloc>(
          create: (context) => NewMessageCountBloc()..add(NewMessageCountLoadRequested(user: (context.read<AuthenticationBloc>().state as AuthAuthenticated).user.username!)),
        ),
      ],
      child: const HomePage(),
    );
  }
}
