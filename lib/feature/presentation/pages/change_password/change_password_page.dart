import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/change_password/change_password_bloc.dart';
import 'change_password_form.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key, this.username = ''});

  static Route<void> route({String username = ''}) {
    return MaterialPageRoute<void>(
        builder: (_) => ChangePasswordPage(
              username: username,
            ));
  }

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          context.read<ChangePasswordBloc>().add(ChangePasswordInit(
              authed: state is AuthAuthenticated,
              username: username));
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Change password'),
            ),
            body: const Padding(
              padding: EdgeInsets.all(12),
              child: ChangePasswordForm(),
            ),
          );
        },
      ),
    );
  }
}
