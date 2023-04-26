import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/utils/logger.dart';
import '../../blocs/change_password/change_password_bloc.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.failure &&
            state.error != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Thay đổi mật khẩu thành công.')),
            );
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Thành công'),
              content: const Text('Thay đổi mật khẩu thành công.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Xác nhận'),
                )
              ],
            ),
          ).whenComplete(() => Navigator.of(context).pop());
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
            builder: (context, state) {
              logger.d(state.authed);
              if (state.authed) {
                return const SizedBox();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _UsernameInput(),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              );
            },
          ),
          const _OldPasswordInput(),
          const SizedBox(
            height: 12,
          ),
          const _NewPasswordInput(),
          const SizedBox(
            height: 12,
          ),
          const _ConfirmPasswordInput(),
          const SizedBox(
            height: 24,
          ),
          _SubmitButton(),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (username) => context
              .read<ChangePasswordBloc>()
              .add(UsernameFieldChanged(username)),
          controller: TextEditingController(text: state.username.value),
          decoration: InputDecoration(
            labelText: 'Mã thẻ',
            errorText: state.username.isNotValid ? 'Mã thẻ không hợp lệ' : null,
          ),
        );
      },
    );
  }
}

class _OldPasswordInput extends StatelessWidget {
  const _OldPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.oldPassword != current.oldPassword,
      builder: (context, state) {
        return TextFormField(
          validator: (_) => state.oldPassword.isNotValid
              ? 'Hãy nhập mật khẩu hiện tại'
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
              label: Text(
                'Mật khẩu',
              ),),
          obscureText: true,
          onChanged: (value) => context
              .read<ChangePasswordBloc>()
              .add(OldPasswordFieldChanged(value)),
        );
      },
    );
  }
}

class _NewPasswordInput extends StatelessWidget {
  const _NewPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword,
      builder: (context, state) {
        return TextFormField(
          validator: (_) => state.newPassword.isNotValid
              ? 'Hãy nhập mật khẩu mới'
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
              label: Text(
                'Mật khẩu mới',
              ),),
          obscureText: true,
          onChanged: (value) => context
              .read<ChangePasswordBloc>()
              .add(NewPasswordFieldChanged(value)),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) {
        return previous.newPassword != current.newPassword ||
            previous.confirmPassword != current.confirmPassword;
      },
      builder: (context, state) {
        return TextFormField(
          validator: (_) => state.confirmPassword.isNotValid
              ? state.confirmPassword.error?.message
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: Text(
              'Xác nhận mật khẩu',
            ),
          ),
          obscureText: true,
          onChanged: (value) => context
              .read<ChangePasswordBloc>()
              .add(ConfirmPasswordFieldChanged(value)),
        );
      },
    );
  }
}


class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus ||
          previous.isValidated != current.isValidated,
      builder: (context, state) {
        return state.submissionStatus.isInProgress
            ? const CircularProgressIndicator()
            : CupertinoButton(
          color: Theme.of(context).primaryColor,
          disabledColor: Theme.of(context).disabledColor,
          onPressed: state.isValidated
              ? () {
            context
                .read<ChangePasswordBloc>()
                .add(const ChangePasswordSubmitted());
          }
              : null,
          child: const Text(
            'Thay đổi mật khẩu',
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
