import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasfast/src/bloc/providerP.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/widgets/btn_complet_form.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:gasfast/src/widgets/background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ProviderP.of(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        BackgroundP().crearFondo(context, 0.70),
        _loginForm(context, bloc)
      ],
    ));
  }

  Widget _loginForm(BuildContext context, LoginBloc bloc) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Padding(
            padding: EdgeInsets.only(right: size.width * 0.1),
            child: Container(
              height: size.width * 0.11,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    child: Text(
                      'INICIAR',
                      style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Text('REGÍSTRATE',
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              color: Colors.grey[600])),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, 'register'))
                ],
              ),
            ),
          )),
          Container(
            width: size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: size.width * 0.005),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.27,
                  child: Lottie.asset('assets/lottie/logo.json',
                      width: double.infinity, repeat: false),
                ),
                _crearEmail(context, bloc),
                _crearPassword(context, bloc),
                _crearBotonRecuperarPassword(context),
                BtnCompletForm(
                    labelText: 'ENTRAR',
                    stringP: bloc.formValidStream,
                    function: bloc,
                    nameFunction: 'login'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(BuildContext context, LoginBloc bloc) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: bloc.emailString,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Correo electrónico',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold)),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontSize: size.height * 0.02,
                      height: size.height * 0.0015),
                  //style: TextStyle(fontSize: 10.0, color: Colors.black),
                  decoration: InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(size.height * 0.02),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      hoverColor: Color.fromRGBO(0, 0, 0, 0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'example@ejemplo.com',
                      //labelText: 'Email',
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                        size: size.height * 0.025,
                      ),
                      //counterText: snapshot.data,
                      errorText: (snapshot.error != null)
                          ? snapshot.error.toString()
                          : null),
                  onChanged: (value) => bloc.changeEmail(value),
                ),
              ],
            ),
          );
        });
  }

  Widget _crearPassword(BuildContext context, LoginBloc bloc) {
    final uiProvider = Provider.of<UiProvider>(context);
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: bloc.passwordString,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.014, bottom: size.height * 0.012),
                  child: Text('Contraseña',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold)),
                ),
                TextField(
                  obscureText: uiProvider.showHide,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      fontSize: size.height * 0.02,
                      height: size.height * 0.0015),
                  decoration: InputDecoration(
                      hintText: '*********',
                      isDense: true,
                      contentPadding: EdgeInsets.all(size.height * 0.02),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      hoverColor: Color.fromRGBO(0, 0, 0, 0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      suffixIcon: IconButton(
                        icon: uiProvider.showHide
                            ? Icon(
                                Icons.lock,
                                size: size.height * 0.025,
                              )
                            : Icon(
                                Icons.lock_open,
                                size: size.height * 0.025,
                              ),
                        color: Colors.black,
                        onPressed: () {
                          if (uiProvider.showHide) {
                            uiProvider.showHide = false;
                          } else {
                            uiProvider.showHide = true;
                          }
                        },
                      ),
                      errorText: (snapshot.error != null)
                          ? snapshot.error.toString()
                          : null,
                      errorMaxLines: 4),
                  onChanged: (value) => bloc.changePassword(value),
                ),
              ],
            ),
          );
        });
  }

  Widget _crearBotonRecuperarPassword(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
            onPressed: () {},
            child: Text(
              'Olvide mi contraseña',
              style:
                  TextStyle(color: Colors.black, fontSize: size.height * 0.018),
            ),
          ),
        ],
      ),
    );
  }
}
