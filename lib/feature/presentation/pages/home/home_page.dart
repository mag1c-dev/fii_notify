import 'dart:math';

import 'package:fii_notify/config/base_url_config.dart';
import 'package:fii_notify/feature/presentation/pages/setting/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/notify.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../blocs/source/source_bloc.dart';
import 'delegate/search_notify_delegate.dart';
import 'notify_content_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<HomeBloc>(
                create: (context) =>
                    HomeBloc()..add(HomePageStarted(user: state.user)),
              ),
              BlocProvider<SourceBloc>(
                create: (context) =>
                SourceBloc()..add(SourceLoadStarted()),
              ),
            ],
            child: Builder(builder: (context) {
              return BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text(state.error!)),
                      );
                  }
                },
                listenWhen: (previous, current) => current.error != null,
                child: Scaffold(
                  drawer: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, homeState) {
                    return Drawer(
                      child: ListView(
                        children: [
                          const _DrawerHeadre(),
                          Divider(
                            color: Theme.of(context).dividerColor,
                          ),
                          ListTile(
                            selected: homeState.notifyType == NotifyType.all,
                            selectedTileColor: homeState.notifyType ==
                                    NotifyType.all
                                ? Theme.of(context).primaryColor.withOpacity(.1)
                                : null,
                            onTap: () {
                              Scaffold.of(context).closeDrawer();
                              context.read<HomeBloc>().add(NotifyTypeSelected(
                                  user: state.user,
                                  notifyType: NotifyType.all));
                            },
                            leading: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: const Icon(
                                  Icons.all_inbox,
                                )),
                            title: Text('Tất cả thông báo',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          ListTile(
                            selected: homeState.notifyType == NotifyType.notice,
                            selectedTileColor: homeState.notifyType ==
                                    NotifyType.notice
                                ? Theme.of(context).primaryColor.withOpacity(.1)
                                : null,
                            onTap: () {
                              Scaffold.of(context).closeDrawer();
                              context.read<HomeBloc>().add(NotifyTypeSelected(
                                  user: state.user,
                                  notifyType: NotifyType.notice));
                            },
                            leading: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: const Icon(
                                  Icons.notifications_active,
                                )),
                            title: Text('Thông báo',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          ListTile(
                            selected:
                                homeState.notifyType == NotifyType.highlight,
                            selectedTileColor: homeState.notifyType ==
                                    NotifyType.highlight
                                ? Theme.of(context).primaryColor.withOpacity(.1)
                                : null,
                            onTap: () {
                              Scaffold.of(context).closeDrawer();
                              context.read<HomeBloc>().add(NotifyTypeSelected(
                                  user: state.user,
                                  notifyType: NotifyType.highlight));
                            },
                            leading: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: const Icon(
                                  Icons.warning,
                                )),
                            title: Text('Cảnh báo',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          ListTile(
                            selected:
                                homeState.notifyType == NotifyType.approval,
                            selectedTileColor: homeState.notifyType ==
                                    NotifyType.approval
                                ? Theme.of(context).primaryColor.withOpacity(.1)
                                : null,
                            onTap: () {
                              Scaffold.of(context).closeDrawer();
                              context.read<HomeBloc>().add(NotifyTypeSelected(
                                  user: state.user,
                                  notifyType: NotifyType.approval));
                            },
                            leading: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: const Icon(
                                  Icons.approval,
                                )),
                            title: Text('Ký duyệt',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          Divider(
                            color: Theme.of(context).dividerColor,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(SettingPage.route());
                            },
                            leading: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: const Icon(
                                  Icons.settings,
                                )),
                            title: Text('Cài đặt',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          ListTile(
                            onTap: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(AuthenticationLogoutRequested());
                            },
                            leading: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: const Icon(
                                  Icons.logout,
                                )),
                            title: Text('Đăng xuất',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                      ),
                    );
                  }),
                  body: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      Builder(builder: (context) {
                        return SliverAppBar(
                          pinned: false,
                          floating: true,
                          snap: false,
                          title: Text(
                            'Fii Notify',
                            style: Theme.of(context).appBarTheme.titleTextStyle,
                          ),
                          leading: IconButton(
                            icon: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: const Icon(Icons.menu)),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  showSearch(context: context, delegate: SearchNotifyDelegate());
                                },
                                icon: IconTheme(
                                    data: Theme.of(context).iconTheme,
                                    child: const Icon(Icons.search)))
                          ],
                        );
                      }),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Tất cả thông báo',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20),
                        sliver: SliverToBoxAdapter(
                          child: BlocBuilder<SourceBloc, SourceState>(
                            buildWhen: (previous, current) =>
                                previous != current,
                            builder: (context, state) {
                              if (state is SourceLoading) {
                                return const Center(child: CupertinoActivityIndicator(),);
                              }
                              if (state is SourceLoadSuccess) {
                                return ChipTheme(
                                  data: Theme.of(context).chipTheme,
                                  child: Wrap(
                                    children: state.sources!
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: ChoiceChip(
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      e.source.isNotEmpty?e.source:'Other',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    if (e.sourceIconURL !=
                                                        null) ...[
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Image.network(
                                                        e.sourceIconURL!,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            const SizedBox(),
                                                        height: 18,
                                                        width: 18,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                                side: BorderSide.none,
                                                labelPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                onSelected: (bool value) {},
                                                selected: e.selected,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          final data = state.listNotify;
                          if (data == null && state.loading) {
                            return const SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                              child: CircularProgressIndicator(),
                            ),);
                          }
                          if (data != null) {
                            return SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final itemIndex = index ~/ 2;
                                if (index.isEven) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => NotifyContentPage(
                                          notify: data[itemIndex],
                                        ),
                                      ));
                                    },
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                      child: Center(
                                        child: data[itemIndex].sourceIconURL !=
                                                null
                                            ? Image.network(
                                                '${BaseUrlConfig().baseUrlProduction}${data[itemIndex].sourceIconURL!}',
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                        'assets/images/fii.png'),
                                              )
                                            : Image.asset(
                                                'assets/images/fii.png'),
                                      ),
                                    ),
                                    title: Text(
                                      '${data[itemIndex].sourceName} - ${data[itemIndex].system}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    subtitle: Text(
                                      data[itemIndex].message?.title ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    // subtitle: Text(
                                    //     '${data[itemIndex].message?.body}'),
                                  );
                                }
                                return Divider(
                                  color: Theme.of(context).dividerColor,
                                );
                              },
                              childCount: max(0, data.length * 2 - 1),
                              semanticIndexCallback: (widget, localIndex) {
                                if (localIndex.isEven) {
                                  return localIndex ~/ 2;
                                }
                                return null;
                              },
                            ));
                          }
                          return const SliverToBoxAdapter(child: SizedBox());
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _DrawerHeadre extends StatelessWidget {
  const _DrawerHeadre({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Image.asset(
                  'assets/images/avt_default.png'),
            ),
          ),
          Text(
            'FII Notify',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
