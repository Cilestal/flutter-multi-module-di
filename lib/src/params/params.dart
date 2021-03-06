part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// Represents the optional params which can be passed to the
/// [Injector] to build dependencies.
abstract class Params {
  /// Gets the param if exists.
  Optional<T> getOptional<T>(String name);

  /// Gets the value or throws.
  T get<T>(String name);

  /// Checks whether a value exists.
  bool contains(String name);

  /// Gets this [Params] as a [Map].
  Map<String, dynamic> get map;

  /// Creates [Params] from a [Map]
  factory Params.fromMap(Map<String, dynamic> map) {
    return (builder()..putMap(map)).build();
  }

  /// Creates an empty [Param] instance.
  factory Params.empty() {
    return builder().build();
  }

  /// Creates a [Param] instance from another.
  factory Params.fromParams(Params params) {
    return (builder()..putParams(params)).build();
  }

  /// Gets a [ParamsBuilder] to create [Params]
  /// instances.
  static ParamsBuilder builder() {
    return ParamsBuilder();
  }
}
