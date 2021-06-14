import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gasfast/src/bloc/providerP.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FinishPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    DateTime now = new DateTime.now();
    final bloc = ProviderP.sendBalance(context);
    final size = MediaQuery.of(context).size;
    var formatter = NumberFormat.currency(locale: "es_MX", symbol: "\$");
    return FadeIn(
      duration: Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBarL().getAppBar(context, false),
        body: Stack(children: <Widget>[
          BackgroundP().crearFondo(context, 0.65),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.only(top: size.height * 0.08),
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.check_circle_outline,
                size: size.height * 0.08,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.02),
              alignment: Alignment.topCenter,
              child: Text('Confirmado', style: TextStyle(fontSize: 18.0)),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.01),
              alignment: Alignment.topCenter,
              child: Text('Abono realizado',
                  style:
                      TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.06),
              alignment: Alignment.topCenter,
              child: Text(
                  'Cantidad: ${formatter.format(double.parse(bloc.balance))}',
                  style: TextStyle(fontSize: 22.0)),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.01),
              alignment: Alignment.topCenter,
              child: Text(
                  'Fecha: ${(now.day > 10) ? now.day : "0" + now.day.toString()}/${(now.month > 10) ? now.month : "0" + now.month.toString()}/${now.year}',
                  style: TextStyle(fontSize: 22.0)),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height * 0.18),
              alignment: Alignment.topCenter,
              child: _crearBoton(context),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    final bloc = ProviderP.sendBalance(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        bloc.changeBalance(0);
        uiProvider.selectViewInter = 0;
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          primary: Colors.grey[850],
          onPrimary: Colors.white,
          onSurface: Colors.grey,
          textStyle: TextStyle(
            color: Color.fromRGBO(232, 188, 2, 1.0),
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(13.0),
          )),
      child: Text(
        'Cerrar',
        style: TextStyle(
            fontSize: 18.0,
            //fontWeight: FontWeight.bold,
            color: Color.fromRGBO(232, 188, 2, 1.0)),
      ),
    );
  }
}
