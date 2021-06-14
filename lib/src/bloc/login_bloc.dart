import 'dart:async';

import 'package:gasfast/src/bloc/validator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // recuperar los datos del string

  Stream<String> get emailString =>
      _emailController.stream.asBroadcastStream().transform(validarEmail);
  Stream<String> get passwordString =>
      _passwordController.stream.asBroadcastStream().transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailString, passwordString, (e, p) => true);

  // insertar valores al string

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // obtener el ultimo valor ingresado en los  stream

  String get email => _emailController.value;
  String get password => _passwordController.value;

  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
