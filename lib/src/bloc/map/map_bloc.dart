import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gasfast/src/helpers/helpers.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gasfast/theme/uber_map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(new MapState());

  //controllador del mapa
  GoogleMapController? _mapController;

  //Polylines
  Polyline _myRount = new Polyline(
    polylineId: PolylineId('my_rount'),
    patterns: [PatternItem.dash(80), PatternItem.gap(40)],
    color: Colors.transparent,
    endCap: Cap.squareCap,
    geodesic: false,
    width: 6,
  );

  //Polylines destination
  Polyline _myRountDestination = new Polyline(
    polylineId: PolylineId('my_rount_destination'),
    patterns: [PatternItem.dash(80), PatternItem.gap(40)],
    color: Colors.white,
    endCap: Cap.squareCap,
    geodesic: false,
    width: 6,
  );

  void initMap(GoogleMapController controller) {
    //if (!state.mapReady) {
    this._mapController = controller;
    this._mapController!.setMapStyle(jsonEncode(mapTheme));
    add(OnMapReady());
    //}
  }

  void activeCard(String nameStation, String address, String id, LatLng coors) {
    add(OnActivateCard(nameStation, address, id, coors));
  }

  void cancelCard() {
    add(OnDisableCard());
  }

  void cancelMap() {
    this._mapController?.dispose();
  }

  void moveCamera(LatLng destination) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is OnMapReady) {
      yield state.copyWith(mapReady: true);
    } else if (event is OnLocationUpdate) {
      yield* this._onNewLocation(event);
    } else if (event is OnMarkRoute) {
      yield* this._onMarkRoute(event);
    } else if (event is OnfollowLocation) {
      if (!state.followLocation!) {
        this.moveCamera(this._myRount.points[this._myRount.points.length - 1]);
      }
      yield state.copyWith(followLocation: !state.followLocation!);
    } else if (event is OnMoveMap) {
      yield state.copyWith(centralLocation: event.centralMap);
    } else if (event is OnCreateDestinationStartPath) {
      yield* this._onCreateDestinationStartPath(event);
    } else if (event is OnCreateStationMarks) {
      yield* this._onCreateStationMarks(event);
    } else if (event is OnActivateCard) {
      yield* this._onActivateCard(event);
      //yield state.copyWith(manualselection: true);
    } else if (event is OnDisableCard) {
      yield state.copyWith(manualselection: false, id: '');
    }
  }

  Stream<MapState> _onNewLocation(OnLocationUpdate event) async* {
    if (state.followLocation!) {
      moveCamera(event.location);
    }
    List<LatLng> points = [...this._myRount.points, event.location];
    this._myRount = this._myRount.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines!['my_rount'] = this._myRount;
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onMarkRoute(OnMarkRoute event) async* {
    if (state.drawTour!) {
      this._myRount = this._myRount.copyWith(colorParam: Colors.white);
    } else {
      this._myRount = this._myRount.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines!['my_rount'] = this._myRount;
    yield state.copyWith(
        drawTour: !state.drawTour!, polylines: currentPolylines);
  }

  Stream<MapState> _onCreateDestinationStartPath(
      OnCreateDestinationStartPath event) async* {
    this._myRountDestination = this._myRountDestination.copyWith(
          pointsParam: event.rutaCoords,
        );
    final currentPolylines = state.polylines;
    currentPolylines!['my_rount_destination'] = this._myRountDestination;

    // icono inicio
    final icon = await getMarkerStartIcon(event.duration.toInt());
    //final icon2 = await getAssetImageMarker();
    final icon2 =
        await getMarkerEndtIcon(event.nameDestination, event.distance);
    // marcadores
    final markerStart = new Marker(
        markerId: MarkerId('start'),
        position: event.rutaCoords[0],
        icon: icon,
        anchor: Offset(0.0, 0.95));

    final markerEnd = new Marker(
        markerId: MarkerId('end'),
        position: event.rutaCoords[event.rutaCoords.length - 1],
        icon: icon2,
        anchor: Offset(0.0, 0.9)
        /*infoWindow: InfoWindow(
            title: '${event.nameDestination}',
            snippet:
                'Distancia: ${(((event.distance / 1000).floor() * 100).toDouble() / 100)} Km')*/
        );

    //final newMarkers = Map.from(state.markers);
    final newMarkers = {...state.markers!};
    newMarkers['start'] = markerStart;
    newMarkers['end'] = markerEnd;

    /*Future.delayed(Duration(milliseconds: 300)).then((value) {
      //_mapController.showMarkerInfoWindow(MarkerId('start'));
      _mapController.showMarkerInfoWindow(MarkerId('end'));
    });*/

    yield state.copyWith(polylines: currentPolylines, markers: newMarkers);
  }

  Stream<MapState> _onCreateStationMarks(OnCreateStationMarks event) async* {
    // icono inicio
    final icon = await getAssetImageMarker();
    //final icon = await getMarkerStationIcon(event.nameDestination);
    // marcador
    final markerStart = new Marker(
        markerId: MarkerId(event.nameDestination),
        position: event.rutaCoords,
        onTap: () async {
          cancelCard();
          await Future.delayed(Duration(milliseconds: 500));
          activeCard(
              event.nameDestination, event.address, event.id, event.rutaCoords);
        },
        icon: icon,
        anchor: Offset(0.0, 0.95));

    final newMarkers = {...state.markers!};

    newMarkers[event.nameDestination] = markerStart;

    yield state.copyWith(markers: newMarkers);
  }

  Stream<MapState> _onActivateCard(OnActivateCard event) async* {
    yield state.copyWith(
        manualselection: true,
        nameStation: event.nameStation,
        address: event.address,
        id: event.id,
        coors: event.coors);
  }
}
