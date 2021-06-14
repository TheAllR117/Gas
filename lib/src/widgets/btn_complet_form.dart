import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasfast/src/bloc/login_bloc.dart';
import 'package:gasfast/src/bloc/providerP.dart';
import 'package:gasfast/src/helpers/helpers.dart';
import 'package:gasfast/src/models/register/register_response.dart';
import 'package:gasfast/src/services/auth_service.dart';

class BtnCompletForm extends StatelessWidget {
  final String? labelText;
  final Stream? stringP;
  final dynamic function;
  final String? nameFunction;

  const BtnCompletForm(
      {Key? key,
      this.labelText,
      this.stringP,
      this.function,
      this.nameFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: stringP,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: snapshot.hasData
                  ? () {
                      HapticFeedback.heavyImpact();
                      FocusScope.of(context).unfocus();
                      switch (nameFunction) {
                        case 'login':
                          _login(function, context);
                          break;
                        case 'register':
                          _register(function, context);
                          break;
                      }
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) =>
                    (snapshot.hasData) ? Colors.black : Colors.black45),
                shape: MaterialStateProperty.resolveWith(
                    (states) => new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(13.0),
                        )),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? Colors.transparent
                        : null;
                  },
                ),
              ),
              /*style: ElevatedButton.styleFrom(
                  primary: Colors.grey[850],
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                  textStyle: TextStyle(
                    color: Color.fromRGBO(232, 188, 2, 1.0),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(13.0),
                  )),*/
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.215, vertical: 12.0),
                child: Text(
                  labelText!,
                  style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(232, 188, 2, 1.0)),
                ),
              ),
            ),
          );
        });
  }

  _login(LoginBloc bloc, BuildContext context) async {
    final authService = new AuthService();

    loading(context);

    final resp = await authService.login(bloc.email, bloc.password);

    Navigator.of(context).pop();
    if (resp) {
      await authService.isLoggedIn();
      await Navigator.popAndPushNamed(context, 'home');
    } else {
      showAlert(context, 'Error', authService.error!.message!);
    }
  }

  _register(RegisterBloc bloc, BuildContext context) async {
    final authService = new AuthService();

    loading(context);

    final resp = await authService.register(
        bloc.name,
        bloc.lastName,
        bloc.secondName,
        bloc.email,
        bloc.password,
        bloc.verifypassword,
        bloc.birthday,
        bloc.gender,
        bloc.phone,
        bloc.vehicleType);

    Navigator.of(context).pop();
    if (resp) {
      await authService.isLoggedIn();
      await Navigator.popAndPushNamed(context, 'home');
    } else {
      var list = [];
      Message msg = authService.errorList!.message!;
      //print(msg);
      msg.toJson().forEach((k, v) => list.add(v[0]));

      showAlertList(context, 'Error', list);
    }
  }
}
