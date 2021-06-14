import 'dart:async';
import 'package:gasfast/src/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _secondNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _verifyPasswordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _birthdayController = BehaviorSubject<String>();
  final _genderController = BehaviorSubject<String>();
  final _platesController = BehaviorSubject<String>();
  final _vehicleTypeController = BehaviorSubject<String>();

  // recuperar los datos del string
  Stream<String> get nameString =>
      _nameController.stream.asBroadcastStream().transform(validarName);

  Stream<String> get lastNameString =>
      _lastNameController.stream.asBroadcastStream().transform(validarName);

  Stream<String> get secondNameString =>
      _secondNameController.stream.asBroadcastStream().transform(validarName);

  Stream<String> get emailString =>
      _emailController.stream.asBroadcastStream().transform(validarEmail);

  Stream<String> get passwordString =>
      _passwordController.stream.asBroadcastStream().transform(validarPassword);

  Stream<String> get verifyPasswordString =>
      _verifyPasswordController.stream.asBroadcastStream().doOnData((String c) {
        if (0 != password.compareTo(c)) {
          _verifyPasswordController.addError("Las contraseñas no coinciden.");
        }
      });

  Stream<String> get phoneString =>
      _phoneController.stream.asBroadcastStream().transform(validarDate);

  Stream<String> get addressString =>
      _addressController.stream.asBroadcastStream().transform(validarName);

  Stream<String> get birthdayString =>
      _birthdayController.stream.asBroadcastStream().transform(validarDate);

  Stream<String> get genderString =>
      _genderController.stream.asBroadcastStream().transform(validarGender);

  Stream<String> get platesString =>
      _platesController.stream.asBroadcastStream().transform(validarPlates);

  Stream<String> get vehicleTypeString =>
      _vehicleTypeController.stream.asBroadcastStream().transform(validarName);

  Stream<bool> get formValidStream => Rx.combineLatest6(
      nameString,
      lastNameString,
      secondNameString,
      emailString,
      passwordString,
      verifyPasswordString,
      (n, l, s, e, p, v) => true);

  // insertar valores al string
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;
  Function(String) get changeSecondName => _secondNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeVerifyPassword =>
      _verifyPasswordController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changebirthday => _birthdayController.sink.add;
  Function(String) get changeGender => _genderController.sink.add;
  Function(String) get changePlates => _platesController.sink.add;
  Function(String) get changeVehicleType => _vehicleTypeController.sink.add;

  // obtener el ultimo valor ingresado en los  stream
  String get name => _nameController.value;
  String get lastName => _lastNameController.value;
  String get secondName => _secondNameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get verifypassword => _verifyPasswordController.value;
  String get phone => _phoneController.value;
  String get address => _addressController.value;
  String get birthday => _birthdayController.value;
  String get gender => _genderController.value;
  String get plates => _platesController.value;
  String get vehicleType => _vehicleTypeController.value;

  void dispose() {
    _nameController.close();
    _lastNameController.close();
    _secondNameController.close();
    _emailController.close();
    _passwordController.close();
    _verifyPasswordController.close();
    _phoneController.close();
    _addressController.close();
    _birthdayController.close();
    _genderController.close();
    _platesController.close();
    _vehicleTypeController.close();
  }
}
