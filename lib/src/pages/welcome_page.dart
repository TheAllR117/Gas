import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/services/auth_service.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime now = new DateTime.now();
final authService = new AuthService();
final newName = authService.userMain!.user!.name.toString().split(' ');
final newBalance =
    authService.userMain!.user!.currentBalance.toDouble().toString().split('.');
CarouselController buttonCarouselController = CarouselController();
var percent = NumberFormat.percentPattern("ar");
var formatter = NumberFormat.currency(locale: "es_MX", symbol: "\$");

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FadeIn(
      child: Scaffold(
        appBar: AppBarL().getAppBar(context, false),
        body: Stack(children: <Widget>[
          BackgroundP().crearFondo(context, 0.25),
          Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bienvenido',
                            style: TextStyle(fontSize: size.height * 0.025),
                          ),
                          Text('${newName[0]} ${newName[1]}',
                              style: TextStyle(
                                  fontSize: size.height * 0.04,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    child: Container(
                      padding: EdgeInsets.all(0),
                      child: Container(
                          height: size.height * 0.04,
                          child: DefaultTabController(
                            length: 2,
                            initialIndex: 0,
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.25),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: TabBar(
                                  tabs: <Tab>[
                                    Tab(
                                        text: 'Abonos',
                                        iconMargin: EdgeInsets.all(0)),
                                    Tab(
                                        text: 'Recibidos',
                                        iconMargin: EdgeInsets.all(0))
                                  ],
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Colors.yellow,
                                  unselectedLabelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black,
                                  ),
                                  onTap: (value) {
                                    buttonCarouselController.animateToPage(
                                        value,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  },
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '${(now.day > 10) ? now.day : "0" + now.day.toString()}/${(now.month > 10) ? now.month : "0" + now.month.toString()}/${now.year}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  _carouselPaymentReceived(context),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.12),
                    child: Text(
                      '¿Qué quieres hacer?',
                      style: TextStyle(
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.03),
              child: _carousel(context),
            )
          ]),
        ]),
      ),
    );
  }

  Widget _carouselPaymentReceived(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CarouselSlider(
      carouselController: buttonCarouselController,
      items: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Text(
              '${formatter.format(double.parse((authService.userMain!.user!.currentBalance).toStringAsFixed(2)))}',
              style: TextStyle(
                  fontSize: size.height * 0.042, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Text(
              '${formatter.format(double.parse((authService.userMain!.user!.beneficiary!).toStringAsFixed(2)))}',
              style: TextStyle(
                  fontSize: size.height * 0.042, fontWeight: FontWeight.bold)),
        ),
      ],
      options: CarouselOptions(
        scrollPhysics: BouncingScrollPhysics(),
        pageSnapping: true,
        height: size.height * 0.05,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        autoPlay: false,
        initialPage: 0,
      ),
    );
  }

  Widget _carousel(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CarouselSlider(
      //carouselController: buttonCarouselController,
      items: <Widget>[for (Widget item in _carouselItem(context)) item],
      options: CarouselOptions(
        height: size.height * 0.3,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlay: true,
        initialPage: 0,
      ),
    );
  }

  _carouselItem(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final List<String> tituloGrande = ['PAGAR', 'ABONAR', 'ENVIAR'];
    final List<String> tituloMini = ['CON ENVIO', 'SALDO', 'SALDO'];
    final List<String> image = ['pngwing', 'credit-card', 'send'];
    final List<int> page = [1, 2, 3];

    final size = MediaQuery.of(context).size;
    List<Widget> items = [];
    for (int i = 0; i < 3; i++) {
      items.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: InkWell(
          onTap: () {
            uiProvider.selectView = page[i];
          },
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.05,
                    horizontal: size.height * 0.03),
                height: size.height * 0.7,
                width: size.width * 0.9,
                child: Card(
                  child: Container(
                      //margin: EdgeInsets.all(30),
                      width: MediaQuery.of(context).size.width,
                      height: size.height * 0.2,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(tituloGrande[i],
                                style: TextStyle(
                                    fontSize: size.height * 0.036,
                                    fontWeight: FontWeight.bold)),
                            Text(tituloMini[i],
                                style: TextStyle(
                                    fontSize: size.height * 0.021,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      )),
                ),
              ),
              Positioned(
                top: -size.height * 0.01,
                left: -size.width * 0.0,
                child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                        child: Image.asset('assets/png/${image[i]}.png',
                            height: size.width * 0.3))),
              )
            ],
          ),
        ),
      ));
    }
    return items;
  }
}
