import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../domain/entities/notify.dart';
import '../../blocs/notify_content/notify_content_bloc.dart';
import '../webview/webview_page.dart';

class NotifyContentPage extends StatelessWidget {
  const NotifyContentPage({
    super.key,
    required this.notify,
  });

  final Notify notify;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotifyContentBloc>(
  create: (context) => NotifyContentBloc()..add(NotifyContentPageStarted(notify: notify)),
  child: Builder(
    builder: (context) {
      return WillPopScope(
        onWillPop: () async{
          if (context.read<NotifyContentBloc>().state.status == NotifyContentStatus.success) {
            Navigator.of(context).pop(notify);
            return false;
          }
          return true;
        },
        child: BlocBuilder<NotifyContentBloc, NotifyContentState>(
  builder: (context, state) {
    return Scaffold(
            appBar: AppBar(
              title: Text(
                  '${notify.source} - ${notify.system}', style: Theme.of(context).appBarTheme.titleTextStyle,),

            ),
            body: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.all(8),
                  child: Text(
                    '${notify.message?.title} - ${notify.createdAt}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection:
                    Axis.vertical,
                    child: Builder(
                        builder: (context) {
                          return Html(
                            data: notify
                                .message
                                ?.body ??
                                '',

                            onLinkTap: (url,
                                ctx,
                                attributes,
                                element) =>
                                Navigator.of(
                                    context)
                                    .push(WebviewPage
                                    .route(
                                    url: url ??
                                        '')),
                            customRender: {
                              "table":
                                  (context, child) {
                                return SingleChildScrollView(
                                  scrollDirection:
                                  Axis.horizontal,
                                  child: (context
                                      .tree
                                  as TableLayoutElement)
                                      .toWidget(
                                      context),
                                );
                              },
                            },
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
  },
),
      );
    }
  ),
);
  }
}
