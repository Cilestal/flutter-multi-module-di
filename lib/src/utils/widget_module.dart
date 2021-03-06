part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

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
