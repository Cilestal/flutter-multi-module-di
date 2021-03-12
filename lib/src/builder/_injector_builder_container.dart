part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

class _InjectorBuilderContainer extends _BinderContainer
    implements InjectorBuilder {
  String name;

  _InjectorBuilderContainer();

  void setName(String name) {
    checkArgument(name != null && name.isNotEmpty,
        message: () => "name can't be null");
    this.name = name;
  }

  @override
  InjectorBuilder child() {
    return _clone();
  }

  @override
  Injector build() {
    return registrations.isNotEmpty
        ? _InjectorContainer(_clone(), name: name)
        : _EmptyInjector(name: name);
  }

  _InjectorBuilderContainer _clone() {
    return _InjectorBuilderContainer()
      ..name = name
      ..registrations.addAll(registrations);
  }

  factory _InjectorBuilderContainer.from(_InjectorContainer container) {
    return _InjectorBuilderContainer()
      ..name = container.name
      ..registrations.addAll(container.container.registrations);
  }
}
