part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapReady extends MapEvent {}

class OnMarkRoute extends MapEvent {}

class OnfollowLocation extends MapEvent {}

class OnActivateCard extends MapEvent {
  final String nameStation;
  final String address;
  final String id;
  final LatLng coors;

  OnActivateCard(this.nameStation, this.address, this.id, this.coors);
}

class OnDisableCard extends MapEvent {}

class OnCreateDestinationStartPath extends MapEvent {
  final List<LatLng> rutaCoords;
  final double distance;
  final double duration;
  final String nameDestination;

  OnCreateDestinationStartPath(
      this.rutaCoords, this.distance, this.duration, this.nameDestination);
}

class OnCreateStationMarks extends MapEvent {
  final LatLng rutaCoords;
  final int positionList;
  final String nameDestination;
  final String address;
  final String id;

  OnCreateStationMarks(this.rutaCoords, this.positionList, this.nameDestination,
      this.address, this.id);
}

class OnMoveMap extends MapEvent {
  final LatLng centralMap;

  OnMoveMap(this.centralMap);
}

class OnLocationUpdate extends MapEvent {
  final LatLng location;

  OnLocationUpdate(this.location);
}
