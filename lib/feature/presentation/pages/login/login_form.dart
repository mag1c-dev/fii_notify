import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../blocs/login/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          if (state.errorMessage == 'PWD_EXPIRED') {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Login failed'),
                content: const Text(
                    'Your password have been expired, please change password to continue!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.of(context).push(ChangePasswordPage.route(
                      //     username: state.username.value));
                    },
                    child: const Text('Confirm'),
                  )
                ],
              ),
            );
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
        }
      },
      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Smart Factory',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 36, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500)),
                ),
              const SizedBox(
                height: 12,
              ),
              _UsernameInput(),
              const SizedBox(
                height: 12,
              ),
              _PasswordInput(),
              const SizedBox(
                height: 12,
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //       onPressed: () {
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => ResetPasswordPage(),
              //         ));
              //       },
              //       child: const Text('Reset password?')),
              // ),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'ID Card',
            errorText: state.username.isNotValid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.showPassword != current.showPassword,
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: !state.showPassword,
          decoration: InputDecoration(
              labelText: 'Password',

              errorText: state.password.isNotValid ? 'invalid password' : null,
              suffixIcon: IconButton(
                  onPressed: () {
                    context
                        .read<LoginBloc>()
                        .add(const LoginPasswordVisibleToggle());
                  },
                  icon: Icon(state.showPassword
                      ? Icons.visibility
                      : Icons.visibility_off))),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus ||
          previous.isValidated != current.isValidated,
      builder: (context, state) {
        return state.submissionStatus.isInProgress
            ? const CircularProgressIndicator()
            : MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).disabledColor,
                elevation: 8.0,
                clipBehavior: Clip.antiAlias,
                minWidth: double.infinity,
                onPressed: state.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              );
      },
    );
  }
}
