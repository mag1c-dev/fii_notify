import 'package:fii_notify/feature/presentation/blocs/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            title: Text('Cài đặt'),
          ),
          SliverToBoxAdapter(
            child: SwitchListTile(
              value: false,
              onChanged: (value) {

              },
              title: Text('Cho phép thông báo'),
              subtitle: Text('Cho phép hiển thị thông báo khi có thông báo mới'),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {

              },
              title: Text('Ngôn ngữ'),
              subtitle: Text('Tiến Việt (Việt Nam), Tiếng Anh (Hoa Kỳ), Tiếng Trung (Trung Quốc)'),
            ),
          ),
          SliverToBoxAdapter(
            child: SwitchListTile(
              value: context.watch<SettingBloc>().state.themeMode == ThemeMode.dark,
              onChanged: (value) {
                context.read<SettingBloc>().add(ThemeModeSelected(themeMode: value?ThemeMode.dark:ThemeMode.light));
              },
              title: Text('Giao diện tối'),
              subtitle: Text('Đang ${context.watch<SettingBloc>().state.themeMode == ThemeMode.dark ? 'bật' : 'tắt'}'),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {

              },
              title: Text('Cập nhật ứng dụng'),
              subtitle: Text('Hiện tại đã là phiên bản mới nhất'),
            ),
          ),
        ],
      ),
    );
  }
}
