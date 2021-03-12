part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _LazySingletonRegistration<T> extends _Registration<T>
    implements LazySingletonBinding<T> {
  @override
  late T instance;
  @override
  final ObjectFactory<T> factory;

  bool _initialized = false;

  @override
  bool get isInstantiated => _initialized;

  _LazySingletonRegistration(this.factory, String? name) : super(name);

  @override
  T getInstance(Injector injector, Params? params) {
    if (!isInstantiated) {
      instance = factory(injector, params);
      _initialized = true;
    }
    return instance;
  }

  @override
  void disposeInstance() {
    if (isInstantiated && instance is DisposableObject) {
      final disposable = instance as DisposableObject;
      disposable.dispose();
    }
  }
}
