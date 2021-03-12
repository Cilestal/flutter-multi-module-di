import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_module_di/flutter_multi_module_di.dart';
import 'package:flutter_multi_module_di_example/bloc/main_bloc.dart';
import 'package:flutter_multi_module_di_example/navigator/main_navigator.dart';

class MainModule extends WidgetModule {
  MainModule(BuildContext context) : super(context);

  @override
  void configureWidget(Binder binder) {
    binder..bindLazySingleton((i, _) => MainBloc(i.get(), i.get()));

    binder..bindLazySingleton((i, _) => MainNavigator(i.get()));
  }
}
