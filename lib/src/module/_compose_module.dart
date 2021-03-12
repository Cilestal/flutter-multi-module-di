part of 'package:flutter_multi_module_di/multi_module_di.dart';

class _ComposeModule implements Module {
  final Iterable<Module> modules;

  _ComposeModule(this.modules);

  @override
  void configure(Binder binder) {
    modules.forEach(binder.install);
  }
}
