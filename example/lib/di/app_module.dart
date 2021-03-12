import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_module_di/multi_module_di.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_module.dart';

class AppModule implements Module {
  final SharedPreferences _preferences;

  AppModule._(this._preferences);

  static Future<Module> create(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    return AppModule._(prefs);
  }

  @override
  void configure(Binder binder) {
    // bind global modules
    binder..bindLazySingleton((i, _) => NetworkModule());

    binder..bindSingleton<SharedPreferences>(_preferences);

    binder..bindSingleton("test_str_description", name: "test_1");
  }
}
