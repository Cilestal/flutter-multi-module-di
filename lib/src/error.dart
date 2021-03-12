part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// Thrown when the [InjectorWidget] is not present.
class InjectorWidgetError extends StateError {
  InjectorWidgetError._internal(String message) : super(message);
  @override
  String toString() {
    return 'InjectorWidgetError: $message';
  }
}
