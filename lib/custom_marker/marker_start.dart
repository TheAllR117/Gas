part of 'custom_markers.dart';

class MarkerInicioPainter extends CustomPainter {
  final int minutes;

  MarkerInicioPainter(this.minutes);
  @override
  void paint(Canvas canvas, Size size) {
    final double circleBlack = 30;
    Paint paint = new Paint()..color = Color.fromRGBO(245, 223, 76, 1.0);
    // dibujar circulo amarillo
    canvas.drawCircle(
        Offset(circleBlack, size.height - circleBlack), 30, paint);

    //circulo negro
    paint.color = Color.fromRGBO(245, 223, 76, 1.0);
    canvas.drawCircle(
        Offset(circleBlack, size.height - circleBlack), 15, paint);

    // sombra
    final Path path = new Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 0);
    path.lineTo(size.width - 10, 140);
    path.lineTo(20, 140);

    canvas.drawShadow(path, Colors.white70, 10, false);

    // dibujar caja amarilla
    //paint.color = Color.fromRGBO(245, 223, 76, 1.0);
    paint.color = Colors.white;

    final boxYellow = Rect.fromLTWH(40, 20, size.width - 55, 120);

    canvas.drawRect(boxYellow, paint);

    paint.color = Color.fromRGBO(245, 223, 76, 1.0);

    final boxBlack = Rect.fromLTWH(45, 25, 110, 110);

    canvas.drawRect(boxBlack, paint);

    // dibujar minutos
    TextSpan textSpam = new TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 50, fontWeight: FontWeight.w400),
        text: '$minutes');

    TextPainter textPainter = new TextPainter(
        text: textSpam,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 110, minWidth: 110);

    textPainter.paint(canvas, Offset(43, 35));

    // dibujar minutos
    textSpam = new TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
        text: 'Min');

    textPainter = new TextPainter(
        text: textSpam,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: 100, minWidth: 100);

    textPainter.paint(canvas, Offset(48, 85));

    // dibujar minutos
    textSpam = new TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.w400),
        text: 'Mi ubicación');

    textPainter = new TextPainter(
        text: textSpam,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(maxWidth: size.width - 130);

    textPainter.paint(canvas, Offset(170, 60));
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}
