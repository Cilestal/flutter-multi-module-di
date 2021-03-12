part of 'package:flutter_multi_module_di/multi_module_di.dart';

class InjectionException implements Exception {
  final String message;

  InjectionException._internal(this.message);

  @override
  String toString() {
    return "InjectionException: $message";
  }
}
