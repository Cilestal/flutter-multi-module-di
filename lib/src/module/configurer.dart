part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// Represents an object able to configure bindings.
abstract class Configurer {
  /// Used to configure all the dependencies.
  void configure(Binder binder);
}
