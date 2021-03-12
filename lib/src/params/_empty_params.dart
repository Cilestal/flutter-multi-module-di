part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _EmptyParams implements Params {
  @override
  Map<String, dynamic> get map => const {};

  @override
  bool contains(String name) {
    return false;
  }

  @override
  T get<T>(String name) {
    throw ParamException._internal("No param with name $name");
  }

  @override
  Optional<T> getOptional<T>(String name) {
    return Optional.absent();
  }
}
