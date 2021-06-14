import 'dart:async';
import 'package:gasfast/src/bloc/validator.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';

class SendBalanceBloc with Validators {
  final _balanceSendController = BehaviorSubject<int>();

  // recuperar los datos del string
  Stream<int> get balanceString => _balanceSendController.stream
      .asBroadcastStream()
      .transform(validarMultiplo);

  // insertar valores al string
  Function(int) get changeBalance => _balanceSendController.sink.add;

  // obtener el ultimo valor ingresado en los  stream
  String get balance => _balanceSendController.value.toString();

  void dispose() {
    _balanceSendController.close();
  }
}
