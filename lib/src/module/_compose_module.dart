part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _ComposeModule implements Module {
  final Iterable<Module> modules;

  _ComposeModule(this.modules);

  @override
  void configure(Binder binder) {
    modules.forEach(binder.install);
  }
}
