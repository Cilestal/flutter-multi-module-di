part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// Builder to construct a [Widget] for the given [Injector].
typedef Widget InjectorWidgetBuilder(Injector injector);

/// Widget able to build it's child from the [Injector] in the
/// current [BuildContext].
class WithInjectorWidget extends StatelessWidget with InjectorWidgetMixin {
  final InjectorWidgetBuilder builder;

  const WithInjectorWidget._internal({Key? key, required this.builder})
      : super(key: key);

  factory WithInjectorWidget(
      {Key? key, required InjectorWidgetBuilder builder}) {
    return WithInjectorWidget._internal(
      key: key,
      builder: builder,
    );
  }

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return builder(injector);
  }
}

/// Builder to construct a [Widget] for the given instance of type [T]
typedef Widget InstanceBuilder<T>(T instance);

/// Widget able to build it's child from the instance found in the [Injector]
/// in the current [BuildContext].
class WithInstanceWidget<T> extends StatelessWidget {
  final InstanceBuilder builder;
  final String? name;
  final Params? params;

  const WithInstanceWidget._internal({
    Key? key,
    required this.builder,
    this.name,
    this.params,
  }) : super(key: key);

  factory WithInstanceWidget(
      {Key? key,
      required InstanceBuilder builder,
      String? name,
      Params? params}) {
    return WithInstanceWidget._internal(
      key: key,
      builder: builder,
      name: name,
      params: params,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WithInjectorWidget(builder: (injector) {
      final instance = injector.get<T>(name: name, params: params);
      return builder(instance);
    });
  }
}

class ChildInjectorWidget extends StatelessWidget with InjectorWidgetMixin {
  final bool autoDispose;
  final Module childModule;
  final InjectorWidgetBuilder injectorBuilder;

  ChildInjectorWidget({
    Key? key,
    this.autoDispose = true,
    required this.childModule,
    required this.injectorBuilder,
  }) : super(key: key);

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return InjectorWidget(
      autoDispose: autoDispose,
      child: WithInjectorWidget(builder: injectorBuilder),
      injector: Injector.fromModule(module: childModule, parent: injector),
    );
  }
}

class ChildInjectorStatefulWidget extends StatefulWidget {
  final bool autoDispose;
  final Module childModule;
  final InjectorWidgetBuilder injectorBuilder;
  final Function(Injector? injector)? onDispose;

  ChildInjectorStatefulWidget({
    Key? key,
    this.autoDispose = true,
    required this.childModule,
    required this.injectorBuilder,
    this.onDispose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChildInjectorStatefulWidgetState();
}

class _ChildInjectorStatefulWidgetState extends State<ChildInjectorStatefulWidget> with InjectorWidgetMixin {
  Injector? _injector;

  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    return InjectorWidget(
      autoDispose: widget.autoDispose,
      child: WithInjectorWidget(builder: widget.injectorBuilder),
      injector: _injector ??= Injector.fromModule(module: widget.childModule, parent: injector),
    );
  }

  @override
  void dispose() {
    widget.onDispose?.call(_injector);
    super.dispose();
  }
}