import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_module_di/flutter_multi_module_di.dart';
import 'package:flutter_multi_module_di_example/bloc/main_bloc.dart';
import 'package:flutter_multi_module_di_example/di/main_module.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChildInjectorWidget(
      childModule: MainModule(context),
      injectorBuilder: (i) {
        final widget = _MainWidget(i.get(), i.get(name: "test_1"));

        return BlocProvider(
          create: (BuildContext context) =>
              i.get<MainBloc>()..add(MainPageOpenedEvent()),
          child: widget,
        );
      },
    );
  }
}

class _MainWidget extends StatelessWidget {
  //ignore: unused_field
  final MainBloc _bloc;
  final String _testSrt;

  _MainWidget(this._bloc, this._testSrt);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoadedState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Test string = $_testSrt",
                        style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
            );
          } else {
            return _progressWidget();
          }
        },
      ),
    );
  }

  Widget _progressWidget() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
