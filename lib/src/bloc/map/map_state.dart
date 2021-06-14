part of 'map_bloc.dart';

@immutable
class MapState {
  final bool? mapReady;
  final bool? drawTour;
  final bool? followLocation;

  final LatLng? centralLocation;

  // Polylies
  final Map<String, Polyline>? polylines;
  // Markers
  final Map<String, Marker>? markers;
  // Markers stations
  final Map<String, Marker>? markersStations;

  final bool? manualselection;

  final String? nameStation;
  final String? address;
  final String? id;
  final LatLng? coors;

  MapState(
      {this.mapReady = false,
      this.drawTour = false,
      this.followLocation = false,
      this.centralLocation,
      Map<String, Polyline>? polylines,
      Map<String, Marker>? markers,
      Map<String, Marker>? markersStations,
      this.manualselection = false,
      this.nameStation = '',
      this.address = '',
      this.id = '',
      this.coors})
      : this.polylines = polylines ?? new Map(),
        this.markers = markers ?? new Map(),
        this.markersStations = markersStations ?? new Map();

  MapState copyWith(
          {bool? mapReady,
          bool? drawTour,
          bool? followLocation,
          LatLng? centralLocation,
          Map<String, Polyline>? polylines,
          Map<String, Marker>? markers,
          Map<String, Marker>? markersStations,
          bool? manualselection,
          String? nameStation,
          String? address,
          String? id,
          LatLng? coors}) =>
      MapState(
          mapReady: mapReady ?? this.mapReady,
          polylines: polylines ?? this.polylines,
          markers: markers ?? this.markers,
          markersStations: markersStations ?? this.markersStations,
          followLocation: followLocation ?? this.followLocation,
          centralLocation: centralLocation ?? this.centralLocation,
          drawTour: drawTour ?? this.drawTour,
          manualselection: manualselection ?? this.manualselection,
          nameStation: nameStation ?? this.nameStation,
          address: address ?? this.address,
          id: id ?? this.id,
          coors: coors ?? this.coors);
}
