[![pub package](https://img.shields.io/pub/v/flutter_multi_module_di.svg)](https://pub.dartlang.org/packages/flutter_multi_module_di)

# Flutter multi module dependency injection

An easy-to-use DI that works based on a dependency tree. 

# Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
    flutter_multi_module_di: latest_version
```

## Multi module example

You can use a dependency tree for the entire application, widget and component.
<p align="center">
<img src="https://raw.githubusercontent.com/cilestal/flutter-multi-module-di/main/diag.png">
</p>

## Usage

```dart
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChildInjectorWidget(
      childModule: MainModule(context),
      injectorBuilder: (i) {
        final widget = _MainWidget(i.get(), i.get(name: "test_1"));

        return BlocProvider(
          create: (BuildContext context) => i.get<MainBloc>()..add(MainPageOpenedEvent()),
          child: widget,
        );
      },
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
    binder..bindLazySingleton((i, _) => MainBloc(i.get(), i.get()));

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
```dart
class TestWidget with InjectorWidgetMixin {
  @override
  Widget buildWithInjector(BuildContext context, Injector injector) {
    injector.get(name: "test_key");
    return Container();
  }
}
```

## WithInjectorWidget & WithInstanceWidget
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
```dart
class TestWidget extends ModuleWidget {
  @override
  void configure(Binder binder) {
    
  }
}
```
