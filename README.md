# Flutter multi module dependency injection

# Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
    flutter_multi_module_di: latest_version
```

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

You can also extend `BindingInjectorWidget` to configure your dependencies:

```dart
class MyBinder extends ModuleWidget {
  MyBinder({Key key, @required Widget child}): super(key: key, child: child);
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(Object());
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
