import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:gasfast/src/models/contact/contact_list_response.dart';
import 'package:gasfast/src/models/contact/contact_search_response.dart';
//import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/contact_service.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';

import 'package:gasfast/src/widgets/card_contact.dart';
import 'package:gasfast/src/widgets/card_contact_loading.dart';
import 'package:lottie/lottie.dart';
//import 'package:provider/provider.dart';

class SendBalancePage extends StatelessWidget {
  const SendBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final uiProvider = Provider.of<UiProvider>(context);
    final contactService = new ContactService();
    final size = MediaQuery.of(context).size;
    String search = '';
    return FadeIn(
      child: Scaffold(
          appBar: AppBarL().getAppBar(context, true),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(children: <Widget>[
              BackgroundP().crearFondo(context, 0.20),
              Column(children: [
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Busca a tu amigo y',
                                style: TextStyle(fontSize: size.height * 0.025),
                              ),
                              Text('Envía Saldo',
                                  style: TextStyle(
                                      fontSize: size.height * 0.04,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.only(left: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
                            ),
                            hoverColor: Color.fromRGBO(255, 255, 255, 0.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: 'Número de Membresía',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: size.height * 0.02),
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: size.height * 0.035,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length == 10) {
                              //print(value);
                              search = value;
                              contactService.getSugerenciasPorQuery(value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.14,
                      ),
                      StreamBuilder(
                          stream: contactService.sugerenciasStreamController,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            return Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Resultados de búsqueda',
                                  style: TextStyle(fontSize: 16),
                                ));
                          }),
                      StreamBuilder(
                          stream: contactService.sugerenciasStreamController,
                          builder: (context,
                              AsyncSnapshot<ContacSearchResponse> snapshot) {
                            if (search == '') {
                              return Container();
                            }
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.data!.partner == null) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                          'assets/lottie/search_fail.json',
                                          width: size.width * 0.3,
                                          reverse: false),
                                      Text(
                                        contactService.message!,
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }

                            final places = snapshot.data!.partner;
                            PartnerL partnerL = PartnerL(
                                name: places!.name,
                                clientId: places.clientId,
                                userId: places.userId,
                                membership: places.membership);

                            if (places.membership == null) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Center(child: Text('No hay resultados')),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              //clipBehavior: Clip.antiAlias,
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.black,
                                        Colors.black,
                                        Colors.black,
                                        Colors.black,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(1.5,
                                            1.5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CardContact(
                                    partnerL: partnerL,
                                    delete: false,
                                  )),
                            );
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Usuarios guardados',
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                      FutureBuilder(
                          future: contactService.contactList(),
                          builder: (context,
                              AsyncSnapshot<List<PartnerL>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text('No hay resultados'),
                                  ),
                                );
                              }
                              final partner = snapshot.data;

                              return SingleChildScrollView(
                                child: SizedBox(
                                  height: size.height * 0.45,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: partner!.length,
                                    itemBuilder: (context, i) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: CardContact(
                                            delete: true,
                                            partnerL: partner[i])),
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox(
                                child: Column(
                                  children: [
                                    CardContactLoading(
                                      direction: true,
                                    ),
                                    CardContactLoading(
                                      direction: false,
                                    ),
                                    CardContactLoading(
                                      direction: true,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                    ]))
              ])
            ]),
          )),
    );
  }
}
