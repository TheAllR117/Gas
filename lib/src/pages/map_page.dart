import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:gasfast/src/bloc/map/map_bloc.dart';
import 'package:gasfast/src/bloc/my_location/my_location_bloc.dart';
import 'package:gasfast/src/services/traffic_service.dart';
import 'package:gasfast/src/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart' as Lottie;
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final trafficService = new TrafficService();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor:
            (Platform.isAndroid) ? Colors.transparent : Colors.blue));

    BlocProvider.of<MyLocationBloc>(context).startTracking();
    super.initState();
  }

  @override
  void dispose() {
    //print('destruir');
    //BlocProvider.of<MapBloc>(context).cancelMap();
    BlocProvider.of<MyLocationBloc>(context).cancelTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeIn(
      child: Scaffold(
        body: Stack(children: <Widget>[
          FadeIn(
            child: Container(
              color: Colors.grey[900],
              child: BlocBuilder<MyLocationBloc, MyLocationState>(
                  builder: (context, state) => creatMap(state)),
            ),
          ),
          Positioned(
            child: Container(
              height: size.height * 0.25,
              width: size.height * 1.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                    Color.fromRGBO(112, 112, 112, 0.6),
                    Color.fromRGBO(112, 112, 112, 0.3),
                    Color.fromRGBO(112, 112, 112, 0.1),
                    Color.fromRGBO(112, 112, 112, 0.0),
                  ])),
              child: Container(
                padding: EdgeInsets.only(
                    left: size.width * 0.042,
                    right: size.width * 0.042,
                    top: size.height * 0.053),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [AppbarButtons(), SearchBar()],
                ),
              ),
            ),
          ),
          ManualMarker(),
          CardPricesDestination()
        ]),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BtnLocation(),
            BtnFollowLocation(),
            //BtnRount(),
            //BtnStation()
          ],
        ),
      ),
    );
  }

  Widget creatMap(MyLocationState state) {
    final size = MediaQuery.of(context).size;
    if (!state.locationExists!)
      return Center(
          child: Lottie.Lottie.asset('assets/lottie/map.json',
              width: size.width * 0.5, reverse: true));

    final mapBloc = BlocProvider.of<MapBloc>(context);

    mapBloc.add(OnLocationUpdate(state.location!));

    final cameraPosition =
        new CameraPosition(target: state.location!, zoom: 15, bearing: 0.9);

    //print(trafficService.stationsList.stations[0].name);

    for (int i = 0; i < trafficService.stationsList!.stations!.length; i++) {
      mapBloc.add(OnCreateStationMarks(
        LatLng(
            double.parse(trafficService.stationsList!.stations![i].latitude!),
            double.parse(trafficService.stationsList!.stations![i].longitude!)),
        i,
        trafficService.stationsList!.stations![i].name!,
        trafficService.stationsList!.stations![i].address!,
        trafficService.stationsList!.stations![i].id.toString(),
      ));
    }

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, _) {
        return GoogleMap(
            initialCameraPosition: cameraPosition,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: mapBloc.initMap,
            polylines: mapBloc.state.polylines!.values.toSet(),
            markers: mapBloc.state.markers!.values.toSet(),
            onCameraMove: (cameraPosition) {
              mapBloc.add(OnMoveMap(cameraPosition.target));
            },
            trafficEnabled: false,
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            onTap: (positionTap) {
              mapBloc.add(OnDisableCard());
            });
      },
    );
  }
}
