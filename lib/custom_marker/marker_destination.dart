part of 'custom_markers.dart';

class MarkerDestinationPainter extends CustomPainter {
  final String description;
  final double meters;

  MarkerDestinationPainter(this.description, this.meters);

  @override
  void paint(Canvas canvas, Size size) {
    final double circleBlack = 30;
    Paint paint = new Paint()..color = Color.fromRGBO(245, 223, 76, 1.0);
    // dibujar circulo amarillo
    canvas.drawCircle(
        Offset(circleBlack, size.height - circleBlack), 30, paint);

    //circulo negro
    paint.color = Colors.black;
    canvas.drawCircle(
        Offset(circleBlack, size.height - circleBlack), 15, paint);

    // sombra
    final Path path = new Path();
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, circleBlack);
    path.lineTo(size.width - 10, 140);
    path.lineTo(0, 140);

    canvas.drawShadow(path, Colors.white70, 10, false);

    // dibujar caja amarilla
    paint.color = Color.fromRGBO(255, 255, 255, 1.0);

    final boxYellow = Rect.fromLTWH(0, 20, size.width - 10, 120);

    canvas.drawRect(boxYellow, paint);

    paint.color = Color.fromRGBO(245, 223, 76, 1.0);

    final boxBlack = Rect.fromLTWH(7, 25, 110, 110);

    canvas.drawRect(boxBlack, paint);

    // dibujar minutos
    double kilometres = this.meters / 1000;
    kilometres = (kilometres * 100).floor().toDouble();
    kilometres = kilometres / 100;
    TextSpan textSpam = new TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.w400),
        text: '$kilometres');

    TextPainter textPainter = new TextPainter(
        text: textSpam,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 120, minWidth: 120);

    textPainter.paint(canvas, Offset(0, 35));

    // dibujar minutos
    textSpam = new TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 35, fontWeight: FontWeight.w400),
        text: 'Km');

    textPainter = new TextPainter(
        text: textSpam,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 120);

    textPainter.paint(canvas, Offset(35, 85));

    // dibujar minutos
    textSpam = new TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 32, fontWeight: FontWeight.w400),
        text: this.description);

    textPainter = new TextPainter(
        text: textSpam,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        maxLines: 2,
        ellipsis: '...')
      ..layout(maxWidth: size.width - 150);

    textPainter.paint(canvas, Offset(140, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
