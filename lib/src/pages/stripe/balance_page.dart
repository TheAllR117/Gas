import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:gasfast/src/bloc/pay/pay_bloc.dart';
import 'package:gasfast/src/helpers/helpers.dart';
//import 'package:gasfast/src/models/errors/error_response.dart';
//import 'package:gasfast/src/models/stripe/stripe_custom_response.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/stripe_service.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';

import 'package:gasfast/src/data/cards.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalancePage extends StatelessWidget {
  final stripeService = new StripeService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uiProvider = Provider.of<UiProvider>(context);
    return FadeIn(
      duration: Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBarL().getAppBar(context, true),
        body: Stack(children: <Widget>[
          BackgroundP().crearFondo(context, 0.25),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.068),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Abonar saldo',
                            style: TextStyle(
                                fontSize: 34.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.068),
                child: _crearBoton(context),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.15),
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.85),
              physics: BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i) {
                final tarjeta = tarjetas[i];
                return GestureDetector(
                  onTap: () {
                    //Navigator.push(context, navegarFadeIn(context, CardPage()));
                    context.read<PayBloc>().add(OnSelectCard(tarjeta));
                    uiProvider.selectViewInter = 1;
                    //print(tarjeta.cardNumberHidden);
                  },
                  child: CreditCardWidget(
                      height: size.width * 0.48,
                      width: size.width * 1.0,
                      cardNumber: tarjeta.cardNumberHidden!,
                      expiryDate: tarjeta.expiracyDate!,
                      cardHolderName: tarjeta.cardHolderName!,
                      cvvCode: tarjeta.cvv!,
                      showBackView: false,
                      cardBgColor: Colors.black),
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    final payBloc = context.read<PayBloc>();
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () async {
          loading(context);
          final amount = payBloc.state.montoPayString;
          final currency = payBloc.state.coin;
          final resp = await this
              .stripeService
              .payWithNewCard(amount: amount, currency: currency!);
          Navigator.pop(context);
          if (resp.ok!) {
            //print('precio ${this.stripeService.pay!.amount}');
            final resp1 = await this.stripeService.makePaymentServer(
                this.stripeService.pay!.id!,
                this.stripeService.pay!.amount!,
                this.stripeService.pay!.currency!,
                '12',
                this.stripeService.pay!.amountCapturable.toString(),
                this.stripeService.pay!.applicationFeeAmount.toString(),
                this.stripeService.pay!.created.toString(),
                '12',
                '12',
                '12');
            if (resp1.ok!) {
              showAlert(context, 'Tarjeta ok', resp1.message!);
            } else {
              showAlert(context, 'Tarjeta Error', resp1.message!);
            }
          } else {
            print(resp.msg);
            showAlert(context, 'Tarjeta false', resp.msg!);
          }
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[850],
            onPrimary: Colors.white,
            onSurface: Colors.grey,
            textStyle: TextStyle(
              color: Color.fromRGBO(232, 188, 2, 1.0),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(13.0),
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.2, vertical: 12.0),
          child: Text(
            'Agregar Tarjeta',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(232, 188, 2, 1.0)),
          ),
        ),
      ),
    );
  }
}
