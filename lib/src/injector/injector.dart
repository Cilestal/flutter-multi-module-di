part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

String _nameOrDefault(String name) => name ?? "injector";

/// Dependency injection container.
abstract class Injector implements DisposableObject {
  /// The name of the injector.
  String get name;

  /// Gets a list of all the [Binding] instances attached
  /// to this [Injector].
  Iterable<Binding> get bindings;

  /// Gets a dependency from the container with optional [name] and [params].
  T get<T>({String name, Params params});

  /// Gets an [Optional] to handle if the registration doesn't exist.
  Optional<T> getOptional<T>({String name, Params params});

  /// Checks whether the container has a given binding.
  bool contains<T>({String name});

  /// Disposes this [Injector] which will clear all the
  /// dependencies and call [Disposable.dispose] on all
  /// singletons implementing the [Disposable] interface.
  @override
  void dispose();

  InjectorBuilder child();

  /// Creates an [Injector] from it's bindings.
  factory Injector(
      {@required BindFunc bindFunc, String name, Injector parent}) {
    checkNotNull(bindFunc, message: () => "bindFunc can't be null");
    final b = parent?.child() ?? Injector.builder();
    if (name != null) b.setName(name);
    bindFunc(b);
    return b.build();
  }

  /// Creates an empty [Injector].
  factory Injector.empty({String name}) {
    return _EmptyInjector();
  }

  /// Creates an [Injector] from a [Module].
  factory Injector.fromModule(
      {@required Module module, String name, Injector parent}) {
    checkNotNull(module, message: () => "module can't be null");
    return Injector(
        name: name, bindFunc: (bind) => bind.install(module), parent: parent);
  }

  /// Creates an [Injector] from a list of [Module] instances.
  factory Injector.fromModules(
      {@required Iterable<Module> modules, String name, Injector parent}) {
    checkNotNull(modules, message: () => "modules can't be null");
    return Injector.fromModule(
        name: name, module: Module.compose(modules), parent: parent);
  }

  /// Creates a [InjectorBuilder] to create [Injector] instances.
  static InjectorBuilder builder() {
    return _InjectorBuilderContainer();
  }
}
