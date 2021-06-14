import 'package:flutter/material.dart';
import 'package:gasfast/custom_marker/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {
  const TestMarkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 700,
          height: 230,
          color: Colors.red,
          child: CustomPaint(
              //painter: MarkerInicioPainter(20),
              painter: MarkerDestinationPainter(
                  'mi casa por algun lado del mundo, esta aquí sfsdsdsdsdfsdsds cscscscss dscscsdsd',
                  2900)),
        ),
      ),
    );
  }
}
