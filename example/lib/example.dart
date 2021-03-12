import 'package:flutter/material.dart';
import 'package:flutter_multi_module_di/multi_module_di.dart';
import 'package:flutter_multi_module_di_example/widget/main_page.dart';

import 'di/app_module.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
        child: FutureBuilder<Module>(
          future: AppModule.create(context),
          builder: (context, future) {
            if (future?.data == null) {
              return Container();
            }

            return InjectorWidget(
              injector: Injector.fromModule(module: future.data),
              child: MainPage(),
            );
          },
        ),
      ),
    );
  }
}
