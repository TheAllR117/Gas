import 'dart:async';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern.toString());
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Correo no valido');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError(
          'La contraseña debe contener mayúsculas, minusculas, un numero y debe contener minimo 8 caracteneres');
    }
  });

  final validarName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    String pattern = r'(?=.*?[a-z]).{3,}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(name)) {
      sink.add(name);
    } else {
      sink.addError('Este campo debe tener almenos 3 letras');
    }
  });

  final validarDate =
      StreamTransformer<String, String>.fromHandlers(handleData: (date, sink) {
    if (date.length == 10) {
      sink.add(date);
    } else {
      sink.addError('Error en el formato');
    }
  });

  final validarGender = StreamTransformer<String, String>.fromHandlers(
      handleData: (gender, sink) {
    if (gender != '') {
      sink.add(gender);
    } else {
      sink.addError('Error en el formato');
    }
  });

  final validarPlates = StreamTransformer<String, String>.fromHandlers(
      handleData: (plates, sink) {
    if (plates.length > 5) {
      sink.add(plates);
    } else {
      sink.addError('Error en el formato');
    }
  });

  final validarMultiplo =
      StreamTransformer<int, int>.fromHandlers(handleData: (balance, sink) {
    if (balance % 50 == 0) {
      sink.add(balance);
    } else {
      sink.addError('El número no es un multiplo de 50');
    }
  });
}
