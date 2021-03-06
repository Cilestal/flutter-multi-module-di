part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// A module to configure injection bindings.
abstract class Module implements Configurer {
  /// Creates a [Module] resulting in the merge of the given modules.
  /// You can also compose modules using [Binder.install] in your [Module.configure].
  factory Module.compose(Iterable<Module> modules) {
    return _ComposeModule(modules);
  }

  /// Creates an empty [Module].
  factory Module.empty() {
    return _EmptyModule();
  }
}
