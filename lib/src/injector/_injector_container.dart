part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _InjectorContainer extends _InjectorBase {
  @override
  bool get disposed => container.disposed;
  final _RegistrationContainer container;

  @override
  Iterable<_Registration> get bindings => container.registrations.values;

  _InjectorContainer(this.container, {String? name}) : super(name: name);

  @override
  bool contains<T>({String? name}) {
    return container.contains(T, name);
  }

  @override
  _Registration getRegistration<T>(String? name) {
    return container.get(T, name);
  }

  @override
  void dispose() {
    container.dispose();
  }

  @override
  InjectorBuilder child() {
    return _InjectorBuilderContainer.from(this);
  }

  @override
  void disposeInstance() {}
}
