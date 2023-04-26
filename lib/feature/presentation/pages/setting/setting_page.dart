import 'package:fii_notify/feature/presentation/blocs/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/device_utils.dart';
import '../../blocs/check_update/check_update_bloc.dart';
import 'application_info_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title:const Text('Cài đặt'),
          ),
          SliverToBoxAdapter(
            child: SwitchListTile(
              value: false,
              onChanged: (value) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Chức năng thông báo đang được phát triển')));
              },
              title:const Text('Cho phép thông báo'),
              subtitle:
              const Text('Cho phép hiển thị thông báo khi có thông báo mới'),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Hiện tại ứng dụng chỉ có ngôn ngữ Tiếng Việt (Việt Nam)')));
              },
              title:const Text('Ngôn ngữ'),
              subtitle:const Text(
                  'Tiếng Việt (Việt Nam)'),
            ),
          ),
          SliverToBoxAdapter(
            child: SwitchListTile(
              value: context.watch<SettingBloc>().state.themeMode ==
                  ThemeMode.dark,
              onChanged: (value) {
                context.read<SettingBloc>().add(ThemeModeSelected(
                    themeMode: value ? ThemeMode.dark : ThemeMode.light));
              },
              title: const Text('Giao diện tối'),
              subtitle: Text(
                  'Đang ${context.watch<SettingBloc>().state.themeMode == ThemeMode.dark ? 'bật' : 'tắt'}'),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ApplicationInfoPage(),));
              },
              title:const Text('Giới thiệu ứng dụng'),
              subtitle:const Text(
                  'FII Notify'),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<CheckUpdateBloc, CheckUpdateState>(
              builder: (context, state) {
                subText() {
                  switch(state.runtimeType){
                    case CheckUpdateSuccess:{
                      final version = (state as CheckUpdateSuccess).module.version;
                      return FutureBuilder<String>(
                        future: DeviceUtils.getVersion(),
                        builder: (context, snapshot) {
                          var message = 'Đang kiểm tra...';
                          if(snapshot.hasData){
                            if(snapshot.data == version){
                              message = 'Phiên bản hiện tại đã là phiên bản mới nhất';
                            }else{
                              message = 'Phiên bản hiện tại: ${snapshot.data}';
                            }
                          }
                          return Text(
                            message,
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        }
                      );
                    }
                    case CheckUpdateError:{
                      return Text(
                        (state as CheckUpdateError).error,
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }
                    case CheckUpdateLoading:{
                      return Text(
                        'Đang kiểm tra...',
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }
                    default:{
                      return Text(
                        'Nhấn để kiểm tra...',
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }
                  }
                }

                return ListTile(
                  onTap: () {
                    context
                        .read<CheckUpdateBloc>()
                        .add(const CheckUpdateStarted(forceShowUpdate: true));
                  },
                  title: const Text('Cập nhật ứng dụng'),
                  subtitle: subText(),
                  trailing: (state is CheckUpdateLoading)
                      ? const CircularProgressIndicator()
                      : (state is CheckUpdateError)
                          ? Icon(
                              Icons.error,
                              color: Theme.of(context).colorScheme.error,
                            )
                          : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
