import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundP {
  crearFondo(BuildContext context, double sizeQ) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.all(0),
        height: size.height * sizeQ,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Color.fromRGBO(245, 223, 76, 1),
              Color.fromRGBO(232, 188, 2, 1),
            ])),
      ),
      Lottie.asset('assets/lottie/wave.json',
          width: size.width * 1.0, reverse: true),
    ]));
  }
}
