import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ApplicationInfoPage extends StatelessWidget {
  const ApplicationInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Application information'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Support',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          'Mr.Tien (Tel: 33717)',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ))
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Email',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          'cpe-vn-fii-app@mail.foxconn.com',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ))
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Created by',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(
                          'FII - App team',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ))
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Version',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    Expanded(
                        flex: 3,
                        child: FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) => snapshot.data !=
                                  null
                              ? Text(
                                  (snapshot.data as PackageInfo).version,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                )
                              : const SizedBox(),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
