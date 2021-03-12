part of 'package:flutter_multi_module_di/multi_module_di.dart';

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
  void doDispose() {
    if (instance is Disposable) {
      final disposable = instance as Disposable;
      disposable.dispose();
    }
  }
}
