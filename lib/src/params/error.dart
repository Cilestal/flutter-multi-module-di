part of 'package:flutter_multi_module_di/multi_module_di.dart';

class ParamException implements Exception {
  final String message;

  ParamException._internal(this.message);

  @override
  String toString() {
    return "ParamException: $message";
  }
}
