import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gasfast/src/models/moves/deposit_response.dart';
import 'package:gasfast/src/services/contact_service.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';
//import 'package:gasfast/src/widgets/btn_complet_form.dart';

import 'package:gasfast/src/widgets/card_movements.dart';
import 'package:gasfast/src/widgets/card_movements_loading.dart';
import 'package:gasfast/src/widgets/input_date_movements.dart';

class DepositsPage extends StatelessWidget {
  const DepositsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactService = new ContactService();
    final size = MediaQuery.of(context).size;

    return FadeIn(
        child: Scaffold(
            appBar: AppBarL().getAppBar(context, true),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Stack(children: <Widget>[
                  BackgroundP().crearFondo(context, 0.07),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.06),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Movimientos',
                                          style: TextStyle(
                                              fontSize: size.height * 0.04,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        'Depósitos',
                                        style: TextStyle(
                                            fontSize: size.height * 0.025),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ])),
                        SizedBox(
                          height: size.height * 0.13,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.065, vertical: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputDateMovements(),
                                InputDateMovements()
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.065, vertical: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 130,
                                  child: ElevatedButton(
                                    //onPressed: () => uiProvider.selectViewInter = 0,
                                    onPressed: () async {},
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.08,
                                            vertical: 12),
                                        primary: Colors.grey[850],
                                        onPrimary: Colors.white,
                                        onSurface: Colors.grey,
                                        textStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(232, 188, 2, 1.0),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(13.0),
                                        )),
                                    child: Text(
                                      'CONSULTAR',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(232, 188, 2, 1.0)),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.065, vertical: 5),
                          child: Text('Movimientos',
                              style: TextStyle(
                                  fontSize: size.height * 0.025,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.06),
                          child: FutureBuilder(
                              future: contactService.deposittList(),
                              builder: (context,
                                  AsyncSnapshot<DepositResponse> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.ok!) {
                                    final partner = snapshot.data;

                                    return SingleChildScrollView(
                                      child: SizedBox(
                                        height: size.height * 0.6,
                                        child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                partner!.deposits!.length,
                                            itemBuilder: (context, i) =>
                                                CardMovements(
                                                  deposit: partner.deposits![i],
                                                )),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text('No hay datos'),
                                    );
                                  }
                                } else {
                                  return SizedBox(
                                    child: Column(
                                      children: [
                                        CardMovementsLoading(
                                          direction: true,
                                        ),
                                        CardMovementsLoading(
                                          direction: false,
                                        ),
                                        CardMovementsLoading(
                                          direction: true,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ])
                ]))));
  }
}
