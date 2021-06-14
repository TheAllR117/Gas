import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gasfast/src/bloc/balance/send_balance_bloc.dart';
import 'package:gasfast/src/bloc/login_bloc.dart';
import 'package:gasfast/src/bloc/register/register_bloc.dart';
export 'package:gasfast/src/bloc/login_bloc.dart';
export 'package:gasfast/src/bloc/register/register_bloc.dart';

class ProviderP extends InheritedWidget {
  /*static ProviderP _instancia;

  factory ProviderP({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderP._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderP._internal({Key key, Widget child}) : super(key: key, child: child);*/
  ProviderP({Key? key, required Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();
  final registerBloc = RegisterBloc();
  final sendBalanceBloc = SendBalanceBloc();

  //ProviderP({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderP>()!.loginBloc;
  }

  static RegisterBloc register(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderP>()!
        .registerBloc;
  }

  static SendBalanceBloc sendBalance(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderP>()!
        .sendBalanceBloc;
  }
}
