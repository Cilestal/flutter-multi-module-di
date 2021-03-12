part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _BinderContainer extends _RegistrationContainer implements Binder {
  @override
  _FactoryRegistration<T> bindFactory<T>(ObjectFactory<T> factory,
      {String? name, bool? override}) {
    final registration = _FactoryRegistration(factory, name);
    put(T, name, registration, override: override);
    return registration;
  }

  @override
  _LazySingletonRegistration<T> bindLazySingleton<T>(ObjectFactory<T> factory,
      {String? name, bool? override}) {
    final registration = _LazySingletonRegistration(factory, name);
    put(T, name, registration, override: override);
    return registration;
  }

  @override
  _SingletonRegistration<T> bindSingleton<T>(T instance,
      {String? name, bool? override}) {
    final registration = _SingletonRegistration(instance, name);
    put(T, name, registration, override: override);
    return registration;
  }

  @override
  Iterable<_Registration> install(Configurer configurer) {
    final binder = _ConfigurerBinderContainer(this);

    try {
      configurer.configure(binder);
    } catch (e) {
      throw InjectionException._internal(
          "Configurer installation failed with reason: $e");
    }

    return binder.registrations.values;
  }
}
