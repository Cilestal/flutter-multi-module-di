import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_module_di/flutter_multi_module_di.dart';
import 'package:flutter_multi_module_di_example/bloc/main_bloc.dart';
import 'package:flutter_multi_module_di_example/di/main_module.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChildInjectorBlocWidget<MainBloc>(
      childModule: MainModule(context),
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
    return SafeArea(
      child: BlocBuilder<MainBloc, MainState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is MainLoadedState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      child: Text("Test string = $_testSrt",
                          style: TextStyle(fontSize: 24)),
                      onTap: () {
                        _bloc.add(MainPageOpenedEvent());
                      },
                    ),
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
