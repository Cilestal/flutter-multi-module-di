part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// [InheritedWidget] containing an [Injector].
class InjectorWidget extends StatefulWidget {
  final Injector injector;
  final Widget child;
  final bool autoDispose;

  const InjectorWidget._internal({
    required this.injector,
    Key? key,
    required this.child,
    this.autoDispose = true,
  }) : super(key: key);

  /// Creates an [InjectorWidget] based on an [Injector].
  factory InjectorWidget({
    Key? key,
    required Injector injector,
    required Widget child,
    bool autoDispose = true,
  }) {
    return InjectorWidget._internal(
      key: key,
      injector: injector,
      child: child,
      autoDispose: autoDispose,
    );
  }

  /// Creates an [InjectorWidget] based on a [BinderFunc].
  factory InjectorWidget.bind({
    Key? key,
    required BindFunc bindFunc,
    required Widget child,
    bool autoDispose = true,
  }) {
    return InjectorWidget(
        key: key,
        injector: Injector(bindFunc: bindFunc),
        child: child,
        autoDispose: autoDispose);
  }

  @override
  _InjectorWidgetState createState() => _InjectorWidgetState();

  /// Gets an [Injector] from a ]BuildContext]
  static Injector of(BuildContext context) {
    final injectorWidget =
        context.dependOnInheritedWidgetOfExactType<_InjectorInheritedWidget>();
    if (injectorWidget == null) {
      throw InjectorWidgetError._internal(
          "No `InjectorWidget` was found in the context.");
    }
    return injectorWidget.injector;
  }
}

class _InjectorWidgetState extends State<InjectorWidget> {
  @override
  Widget build(BuildContext context) {
    return _InjectorInheritedWidget(
      injector: widget.injector,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.autoDispose) {
      widget.injector.dispose();
    }
  }
}

class _InjectorInheritedWidget extends InheritedWidget {
  final Injector injector;

  const _InjectorInheritedWidget({
    required this.injector,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InjectorInheritedWidget oldWidget) {
    return oldWidget.injector != injector;
  }
}
