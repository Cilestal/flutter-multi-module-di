part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// Utility to get the default injector from the registry.
class InjectorMixin {
  /// Gets the [Injector].
  Injector getInjector({String name}) {
    return InjectorRegistry.instance.get(name: name);
  }
}
