part of 'package:flutter_multi_module_di/flutter_multi_module_di.dart';

/// Utility base [Widget] to set up bindings.
abstract class ModuleWidget extends StatelessWidget implements Configurer {
  final Widget child;

  const ModuleWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: configure,
      child: child,
    );
  }
}
