import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasfast/src/bloc/pay/pay_bloc.dart';
import 'package:gasfast/src/bloc/providerP.dart';
import 'package:gasfast/src/helpers/helpers.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/auth_service.dart';
import 'package:gasfast/src/services/stripe_service.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';
import 'package:gasfast/src/widgets/input_money.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stripe_payment/stripe_payment.dart';

class CardPage extends StatelessWidget {
  final stripeService = new StripeService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = ProviderP.sendBalance(context);
    return FadeIn(
      duration: Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBarL().getAppBar(context, true),
        body: Stack(children: <Widget>[
          BackgroundP().crearFondo(context, 0.1),
          SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.068),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      alignment: Alignment.centerLeft,
                      child: Text('Abonar saldo',
                          style: TextStyle(
                              fontSize: 34.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.18, bottom: size.height * 0.01),
                      alignment: Alignment.centerLeft,
                      child: Text('Datos de envio',
                          style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                    ),
                    InputMoney(
                      stringP: bloc.balanceString,
                      funcion: bloc.changeBalance,
                      labelText: 'Cantidad',
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.015, bottom: size.height * 0.01),
                      alignment: Alignment.centerRight,
                      child: Text('Multiplos de 50',
                          style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.049, bottom: size.height * 0.0),
                      alignment: Alignment.center,
                      child: _crearBoton(context),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    final bloc = ProviderP.sendBalance(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final size = MediaQuery.of(context).size;
    final authService = new AuthService();
    return StreamBuilder(
        stream: bloc.balanceString,
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: (snapshot.hasData && snapshot.data != null)
                ? () async {
                    loading(context);
                    final payBloc = BlocProvider.of<PayBloc>(context).state;
                    final card = payBloc.card;
                    final mouthYear = card!.expiracyDate!.split('/');

                    final resp = await stripeService.payWithExistingCard(
                        amount: '${(int.parse(bloc.balance) * 100).floor()}',
                        currency: payBloc.coin!,
                        card: CreditCard(
                            number: card.cardNumber,
                            expMonth: int.parse(mouthYear[0]),
                            expYear: int.parse(mouthYear[1])));

                    if (resp.ok!) {
                      final resp1 = await this.stripeService.makePaymentServer(
                          this.stripeService.pay!.id!,
                          this.stripeService.pay!.amount!,
                          this.stripeService.pay!.currency!,
                          '12',
                          this.stripeService.pay!.amountCapturable.toString(),
                          this
                              .stripeService
                              .pay!
                              .applicationFeeAmount
                              .toString(),
                          this.stripeService.pay!.created.toString(),
                          '12',
                          '12',
                          '12');
                      if (resp1.ok!) {
                        await authService.isLoggedIn();
                        Navigator.pop(context);
                        uiProvider.selectViewInter = 2;
                        //showAlert(context, 'Tarjeta ok', resp1.message);
                      } else {
                        Navigator.pop(context);
                        showAlert(context, 'Tarjeta Error', resp1.message!);
                      }
                    } else {
                      print(resp.msg);
                      showAlert(context, 'Tarjeta false', resp.msg!);
                    }

                    //uiProvider.selectViewInter = 2;
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
