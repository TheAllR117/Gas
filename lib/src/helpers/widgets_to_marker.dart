part of 'helpers.dart';

Future<BitmapDescriptor> getMarkerStartIcon(int seconds) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);

  final size = new ui.Size(500, 220);

  final minutes = (seconds / 60).floor();

  final markerStart = new MarkerInicioPainter(minutes);

  markerStart.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getMarkerEndtIcon(
    String description, double meters) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);

  final size = new ui.Size(500, 220);

  //final minutes = (seconds / 60).floor();

  final markerStart = new MarkerDestinationPainter(description, meters);

  markerStart.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

Future<BitmapDescriptor> getMarkerStationIcon(String description) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);

  final size = new ui.Size(500, 220);

  final markerStart = new MarkerDestinationPainter(description, 10);

  markerStart.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
