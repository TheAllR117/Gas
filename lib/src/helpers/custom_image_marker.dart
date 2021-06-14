part of 'helpers.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.5, size: Size(50, 50)),
      'assets/png/circle_destination.png');
}
