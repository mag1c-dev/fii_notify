import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../domain/entities/notify.dart';
import '../webview/webview_page.dart';

class NotifyContentPage extends StatelessWidget {
  const NotifyContentPage({
    super.key,
    required this.notify,
  });

  final Notify notify;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${notify.sourceName} - ${notify.system}', style: Theme.of(context).appBarTheme.titleTextStyle,),

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
  }
}
