import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:gasfast/src/providers/ui_provider.dart';
import 'package:gasfast/src/widgets/app_bar.dart';
import 'package:gasfast/src/widgets/background.dart';
import 'package:provider/provider.dart';

class MovePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FadeIn(
      child: Scaffold(
        appBar: AppBarL().getAppBar(context, false),
        body: Stack(children: <Widget>[
          BackgroundP().crearFondo(context, 0.10),
          Column(children: [
            Container(
              //decoration: BoxDecoration(color: Colors.black),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Movimientos',
                              style: TextStyle(
                                  fontSize: size.height * 0.04,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.25),
              child: _carousel(context),
            )
          ]),
        ]),
      ),
    );
  }

  Widget _carousel(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CarouselSlider(
      //carouselController: buttonCarouselController,
      items: <Widget>[for (Widget item in _carouselItem(context)) item],
      options: CarouselOptions(
        height: size.height * 0.4,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlay: true,
        initialPage: 0,
      ),
    );
  }

  _carouselItem(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final List<String> tituloGrande = ['DEPÓSITOS', 'TRANSFERENCIAS', 'PAGOS'];
    final List<String> image = ['credit-card', 'send', 'pngwing'];
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
                            Container(
                                alignment: Alignment.center,
                                child: Image.asset('assets/png/${image[i]}.png',
                                    width: size.width * 0.3)),
                            Container(
                              alignment: Alignment.center,
                              child: Text(tituloGrande[i],
                                  style: TextStyle(
                                      fontSize: size.height * 0.036,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return items;
  }
}
