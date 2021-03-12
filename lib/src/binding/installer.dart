part of 'package:flutter_multi_module_di/multi_module_di.dart';

/// Represents an object able to install dependencies in
/// a [Configurer].
abstract class Installer {
  /// Installs all the dependencies from the given [Configurer].
  Iterable<Binding> install(Configurer configurer);
}
