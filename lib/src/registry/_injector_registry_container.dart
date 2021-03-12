part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _InjectorRegistryContainer extends Object
    with DisposableObject
    implements InjectorRegistry {
  final Map<String, Injector> _map = {};

  @override
  Injector get({String? name}) {
    final injector = _map[_nameOrDefault(name)];
    if (injector == null) {
      throw InjectionException._internal(
          "Injector with name `$name` does not exist");
    }
    return injector;
  }

  @override
  void register(Injector injector, {bool override = false}) {
    final name = injector.name;

    if (_map.containsKey(name) && !override) {
      throw InjectionException._internal(
          "Injector with name `$name` already exists");
    }

    _map[name] = injector;
  }

  @override
  void registerAll(Iterable<Injector> injectors, {bool override = false}) {
    injectors.forEach((injector) => register(injector, override: override));
  }

  @override
  bool contains({String? name}) {
    return _map.containsKey(_nameOrDefault(name));
  }

  @override
  void disposeInstance() {
    _map.values.forEach((injector) => injector.dispose());
    _map.clear();
  }
}
