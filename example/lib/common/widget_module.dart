import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_module_di/multi_module_di.dart';

abstract class WidgetModule implements Module {
  final BuildContext _context;

  WidgetModule(this._context);

  @override
  void configure(Binder binder) {
    binder..bindSingleton<BuildContext>(_context, override: true);
    configureWidget(binder);
  }

  void configureWidget(Binder binder);
}
