import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_module_di_example/navigator/main_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  //ignore: unused_field
  final MainNavigator _navigator;
  //ignore: unused_field
  final SharedPreferences _sharedPreferences;

  MainBloc(this._navigator, this._sharedPreferences)
      : super(MainLoadingState());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainPageOpenedEvent) {
      await Future.delayed(Duration(seconds: 2));
      yield MainLoadedState();
    }
  }
}

abstract class MainEvent {}

class MainPageOpenedEvent extends MainEvent {}

abstract class MainState {}

class MainLoadingState extends MainState {}

class MainLoadedState extends MainState {}
