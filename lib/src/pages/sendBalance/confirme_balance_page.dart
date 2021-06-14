import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gasfast/src/bloc/providerP.dart';
import 'package:gasfast/src/helpers/helpers.dart';
import 'package:gasfast/src/models/balance/send_balance_responce.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/auth_service.dart';
import 'package:gasfast/src/services/contact_service.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';
import 'package:gasfast/src/widgets/input_money.dart';
//import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';
//import "package:intl/intl.dart";

class ConfirmeBalancePage extends StatelessWidget {
  const ConfirmeBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ProviderP.sendBalance(context);
    final contactService = new ContactService();
    final size = MediaQuery.of(context).size;

    return FadeIn(
        child: Scaffold(
            appBar: AppBarL().getAppBar(context, true),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Stack(children: <Widget>[
                  BackgroundP().crearFondo(context, 0.10),
                  Column(children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.06),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Estás enviando saldo a',
                                      style: TextStyle(
                                          fontSize: size.height * 0.02),
                                    ),
                                    Text('${contactService.partnerL!.name}',
                                        style: TextStyle(
                                            fontSize: size.height * 0.04,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      '${contactService.partnerL!.membership}',
                                      style: TextStyle(
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.17,
                            ),
                            Container(
                              //padding: EdgeInsets.symmetric(vertical: 14),
                              alignment: Alignment.centerLeft,
                              child: Text('Datos de envio'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12, bottom: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 16,
                                        bottom: 30,
                                        right: 10),
                                    //margin: EdgeInsets.only(top: 14, bottom: 10),
                                    decoration: BoxDecoration(
                                      //color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  InputMoney(
                                    stringP: bloc.balanceString,
                                    funcion: bloc.changeBalance,
                                    labelText: 'Cantidad a enviar',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text('Múltiplos de 50'),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            _crearBoton(context)
                          ],
                        ))
                  ])
                ]))));
  }

  Widget _crearBoton(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final bloc = ProviderP.sendBalance(context);
    final authService = new AuthService();
    final contactService = new ContactService();
    //final uiProvider = Provider.of<UiProvider>(context);
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: bloc.balanceString,
        builder: (context, snapshot) {
          return ElevatedButton(
            //onPressed: () => uiProvider.selectViewInter = 0,
            onPressed: (snapshot.hasData && snapshot.data != null)
                ? () async {
                    loading(context);
                    SendBalanceResponse resp = await contactService.sendBalance(
                        contactService.partnerL!.userId.toString(),
                        snapshot.data.toString());
                    if (resp.ok!) {
                      await authService.isLoggedIn();
                      Navigator.of(context).pop();
                      uiProvider.selectViewInter = 2;
                      //showAlert(context, 'Envio de saldo', resp.message);
                    } else {
                      Navigator.of(context).pop();
                      showAlertList(context, 'Error', resp.message.balance);
                      //print(resp.message.balance);
                    }
                  }
                : null,
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
              'Enviar',
              style: TextStyle(
                  fontSize: 18.0,
                  //fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(232, 188, 2, 1.0)),
            ),
          );
        });
  }
}
