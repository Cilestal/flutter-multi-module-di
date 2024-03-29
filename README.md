[![pub package](https://img.shields.io/pub/v/flutter_multi_module_di.svg)](https://pub.dartlang.org/packages/flutter_multi_module_di)

# Flutter multi module dependency injection

An easy-to-use DI that works based on a dependency tree. 

Medium article: https://medium.com/@michaelcilestal/multi-module-dependency-injection-in-flutter-5e07b3568d28

# Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

<b>Important note:</b>

From 2.0.0 and onwards, flutter_multi_module_di uses null-safe code.

```yaml
dependencies:
    flutter_multi_module_di: latest_version
```

## Multi module example

You can use a dependency tree for the entire application, widget and component.
<p align="center">
<img src="https://raw.githubusercontent.com/cilestal/flutter-multi-module-di/main/diag.svg">
</p>

## Usage

```dart
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChildInjectorStatefulWidget(
      childModuleBuilder: () => MainModule(context),
      injectorBuilder: (i) => _MainWidget(i.get(), i.get(name: "test_1")),
    );
  }
}

class _MainWidget extends StatelessWidget {
  final MainBloc _bloc;
  final String _testSrt;

  _MainWidget(this._bloc, this._testSrt);

  @override
  Widget build(BuildContext context) {
   ...
  }
}
```

You can also extend `WidgetModule` to configure your dependencies:

```dart
class MainModule extends WidgetModule {
  MainModule(BuildContext context) : super(context);

  @override
  void configureWidget(Binder binder) {
    binder..bindLazySingleton((i, _) => MainBloc(i.get(), i.get())..add(MainPageOpenedEvent()));

    binder..bindLazySingleton((i, _) => MainNavigator(i.get()));
  }
}
```

or use common dart module

```dart
class TestModule extends Module {
  @override
  void configure(Binder binder) {
    // impl
  }
}
```

You can later refer to the injector like any other `InheritedWidget`.

```dart
class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final injector = InjectorWidget.of(context);
    final apiKey = injector.get(name: "api_key");
    return SomeContainerNeedingTheKey(apiKey);
  }
}
```

Or using the `InjectorWidgetMixin`:

```dart
class SomeWidget extends StatelessWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    final object = injector.get<Object>();
    print(object);
    return Container();
  }
}
```


# Full api

## ChildInjectorStatefulWidget

Creates a singleton module containing the child module and parent dependencies

```dart
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChildInjectorStatefulWidget(
      childModuleBuilder: () => MainModule(context),
      injectorBuilder: (i) => _MainWidget(i.get(), i.get(name: "test_1")),
    );
  }
}
```

## ChildInjectorWidget

Creates a new module containing the child module and parent dependencies

```dart
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChildInjectorWidget(
      childModule: MainModule(context),
      injectorBuilder: (injector) {
       ...
      },
    );
  }
}
```

## InjectorWidget
[InheritedWidget] containing an [Injector].

```dart
@override
Widget build(BuildContext context) {
  return InjectorWidget(
    child: Text(""),
    injector: Injector.fromModule(module: ...),
    autoDispose: true, // default: true
  );
}
```

## InjectorWidgetMixin
Utility mixin to easily use the injector in the [InjectorWidget]. This can be applied to [State] or to [StatelessWidget] classes.

```dart
class TestWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    injector.get(name: "test_key");
    return Container();
  }
}
```

## WithInjectorWidget
Widget able to build it's child from the [Injector] in the current [BuildContext].

```dart
@override
Widget build(BuildContext context) {
  return WithInjectorWidget(
    builder: (injector) {
      injector.get(name: "test");
      return Container();
    },
  );
}
```
## WithInstanceWidget
Widget able to build it's child from the instance found in the [Injector] in the current [BuildContext].

```dart
@override
Widget build(BuildContext context) {
  return WithInstanceWidget<SharedPreferences>(
    builder: (sharedPrefs) {
      return Container();
    },
  );
}
```

## ModuleWidget
Utility base [Widget] to set up bindings.
```dart
class TestWidget extends ModuleWidget {
  @override
  void configure(Binder binder) {
    
  }
}
```
