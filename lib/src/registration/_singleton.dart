part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _SingletonRegistration<T> extends _Registration<T>
    implements SingletonBinding<T> {
  @override
  final T instance;

  _SingletonRegistration(this.instance, String name) : super(name);

  @override
  T getInstance(Injector injector, Params params) {
    return instance;
  }

  @override
  void disposeInstance() {
    if (instance is DisposableObject) {
      final disposable = instance as DisposableObject;
      disposable.dispose();
    }
  }
}
