import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fii_notify/feature/presentation/blocs/notify_content/notify_content_bloc.dart';
import 'package:fii_notify/feature/presentation/pages/setting/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/notify.dart';
import '../../../domain/entities/source.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../blocs/new_message_count/new_message_count_bloc.dart';
import '../../blocs/source/source_bloc.dart';
import 'notify_content_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<HomeBloc>().add(const LoadMoreRequested());
      }
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state.error != null) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(state.error!),
                        ),
                      );
                  }
                },
                listenWhen: (previous, current) => current.error != null,
              ),
            ],
            child: Scaffold(
              drawer: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) {
                return Drawer(
                  child: ListView(
                    children: [
                      const _DrawerHeader(),
                      Divider(
                        color: Theme.of(context).dividerColor,
                      ),
                      BlocBuilder<NewMessageCountBloc, NewMessageCountState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          return _ActionList(
                              currentSelected: homeState.notifyType,
                              items: [
                                _ActionItemModel(
                                  type: NotifyType.all,
                                  icon: const Icon(Icons.all_inbox),
                                  newCount: 0,
                                ),
                                _ActionItemModel(
                                  type: NotifyType.notice,
                                  icon: const Icon(Icons.notifications),
                                  newCount: state.notify,
                                ),
                                _ActionItemModel(
                                  type: NotifyType.highlight,
                                  icon: const Icon(Icons.warning),
                                  newCount: state.highlight,
                                ),
                                _ActionItemModel(
                                  type: NotifyType.approval,
                                  icon: const Icon(Icons.approval),
                                  newCount: state.approval,
                                ),
                              ]);
                        },
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
              body: RefreshIndicator(
                onRefresh: () async{
                  context.read<HomeBloc>().add(const RefreshedHomeEvent());
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: CustomScrollView(
                  controller: _scrollController,
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
                        actions: const [
                          // IconButton(
                          //     onPressed: () {
                          //       showSearch(
                          //           context: context,
                          //           delegate: SearchNotifyDelegate());
                          //     },
                          //     icon: IconTheme(
                          //         data: Theme.of(context).iconTheme,
                          //         child: const Icon(Icons.search)))
                        ],
                      );
                    }),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            return Text(
                              state.notifyType.vnName,
                              style: Theme.of(context).textTheme.titleSmall,
                            );
                          },
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: BlocBuilder<SourceBloc, SourceState>(
                          buildWhen: (previous, current) => previous != current,
                          builder: (context, state) {
                            if (state.status == SourceStatus.loading && state.sources == null) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            if (state.sources != null) {
                              return ChipTheme(
                                data: Theme.of(context).chipTheme,
                                child: Wrap(
                                  children: state.sources!
                                      .map((e) => Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8.0),
                                            child: _SourceWidget(
                                              source: e,
                                              onTap: (Source source, bool value) {
                                                context.read<HomeBloc>().add(
                                                    SourceSelectedHomeEvent(
                                                        source: value
                                                            ? source
                                                            : null));
                                              },
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
                            ),
                          );
                        }
                        if (data != null) {
                          return SliverList(
                              delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final itemIndex = index ~/ 2;
                              if (index.isEven) {
                                return NotifyItem(notify: data[itemIndex]);
                              }
                              if (index == data.length * 2 - 1) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return Divider(
                                color: Theme.of(context).dividerColor,
                              );
                            },
                            childCount: max(0, data.length * 2),
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
            ),
          );
        });
      },
    );
  }
}

class _SourceWidget extends StatelessWidget {
  const _SourceWidget({
    required this.source,
    required this.onTap,
  });

  final Source source;
  final Function(Source source, bool value) onTap;

  @override
  Widget build(BuildContext context) {
    final selected =
        source.id == context.watch<HomeBloc>().state.currentSource?.id;

    return RawChip(

      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          if (source.sourceIconURL != null) ...[
            const SizedBox(
              width: 5,
            ),
            CachedNetworkImage(
              imageUrl: source.sourceIconURL!,
              imageBuilder: (context, imageProvider) => Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  )),
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const SizedBox(),
              fit: BoxFit.fitHeight,
            ),
          ],
          const SizedBox(width: 5,),
          Text(
            '${source.source.isNotEmpty ? source.source : 'Other'} ${source.unreadNumber! > 0 ? '(${source.unreadNumber})': ''}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: selected ? Colors.white : null),
          ),
        ],
      ),

      selectedColor: Theme.of(context).colorScheme.secondary,
      side: BorderSide.none,
      labelPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      onSelected: (bool value) {
        onTap.call(source, value);
      },
      showCheckmark: false,
      selected: selected,
    );
  }
}

class NotifyItem extends StatelessWidget {
  const NotifyItem({
    super.key,
    required this.notify,
  });

  final Notify notify;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final markReadNotify = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotifyContentPage(
            notify: notify,
          ),
        ));
        if (markReadNotify != null && context.mounted) {
          context.read<HomeBloc>().add(NotifyReadHomeEvent(notify: markReadNotify as Notify));
          context.read<SourceBloc>().add(const NotifyReadSourceEvent());
        }
      },
      leading: Container(
        height: 50,
        width: 50,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Builder(builder: (context) {
          final String? icon = notify.sourceIconURL;
          return Center(
            child: icon != null
                ? CachedNetworkImage(
                    imageUrl: icon,
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/fii.png'),
                  )
                : Image.asset('assets/images/fii.png'),
          );
        }),
      ),
      title: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${notify.source} - ${notify.system}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: (notify.read!)?FontWeight.w400:null),
              ),
              Text(
                notify.createdAt ?? '',
                style: Theme.of(context).textTheme.labelSmall!.copyWith( color: (notify.read!)?Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.6):null, fontWeight: (notify.read!)?FontWeight.w400:null),
              )
            ],
          );
        }
      ),
      subtitle: Text(
        notify.message?.title ?? '',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: (notify.read!)?Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.6):null, fontWeight: (notify.read!)?FontWeight.w400:null),
      ),
    );
  }
}



class _ActionItemModel {
  final NotifyType type;
  final Icon icon;
  final int newCount;

  _ActionItemModel({
    required this.type,
    required this.icon,
    required this.newCount,
  });
}

class _ActionList extends StatelessWidget {
  const _ActionList({
    required this.currentSelected,
    required this.items,
  });

  final NotifyType currentSelected;
  final List<_ActionItemModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (e) => _ActionItemWidget(
              title: e.type.vnName,
              icon: e.icon,
              newCount: e.newCount,
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context
                    .read<HomeBloc>()
                    .add(NotifyTypeSelected( notifyType: e.type));
              },
              selected: currentSelected == e.type,
            ),
          )
          .toList(),
    );
  }
}

class _ActionItemWidget extends StatelessWidget {
  const _ActionItemWidget({
    required this.selected,
    required this.title,
    required this.newCount,
    required this.onTap,
    required this.icon,
  });

  final bool selected;
  final String title;
  final int newCount;
  final Icon icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      trailing: newCount > 0
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('${newCount > 99 ? '99+' : newCount}', style: Theme.of(context).textTheme.titleSmall),
            )
          : null,
      selectedTileColor:
          selected ? Theme.of(context).highlightColor : null,
      onTap: onTap,
      leading: IconTheme(
        data: Theme.of(context).iconTheme,
        child: icon,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Image.asset('assets/images/avt_default.png'),
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
