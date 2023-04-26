import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';


class UserInformationPage extends StatelessWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('User information'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //search bar
            //CupertinoSearchTextField(),
            Expanded(
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if(state is AuthAuthenticated){
                    final user = state.user;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ItemInfo(
                          tittle: 'ID Card',
                          des: user.username??'',
                        ),
                        const Divider(),
                        ItemInfo(
                          tittle: 'Full name',
                          des: user.name??'',
                        ),
                        const Divider(),
                        ItemInfo(
                          tittle: 'Email',
                          des: user.email??'',
                        ),
                        const Divider(),
                        ItemInfo(
                          tittle: 'BU',
                          des: user.bu ?? '',
                        ),
                        const Divider(),
                        ItemInfo(
                          tittle: 'CFT',
                          des: user.cft ?? '',
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemInfo extends StatelessWidget {
  final String tittle;
  final String des;

  const ItemInfo({Key? key, required this.tittle, required this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                tittle,
                style: Theme.of(context).textTheme.titleMedium,
              )),
          Expanded(
              flex: 3,
              child: Text(
                des,
                style: Theme.of(context).textTheme.bodyMedium,

              ))
        ],
      ),
    );
  }
}
