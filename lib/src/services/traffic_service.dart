import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gasfast/global/environment.dart';
import 'package:gasfast/src/helpers/debouncer.dart';
import 'package:gasfast/src/models/errors/error_response.dart';
import 'package:gasfast/src/models/map/gasoline_prices_response.dart';
import 'package:gasfast/src/models/map/reverse_query_response.dart';
import 'package:gasfast/src/models/map/search_response.dart';
import 'package:gasfast/src/models/map/stations_response.dart';
import 'package:gasfast/src/models/map/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class TrafficService {
  // Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }
  StationsListResponse? stationsList;
  ErrorResponse? error;
  GasolinePricesResponse? prices;
  // Create storage
  final _storage = new FlutterSecureStorage();
  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400));
  // ignore: close_sinks
  final StreamController<SearchMapResponse> _sugerenciasStreamController =
      new StreamController<SearchMapResponse>.broadcast();

  Stream<SearchMapResponse> get sugerenciasStreamController =>
      this._sugerenciasStreamController.stream;
  final String _baseUrl = 'https://api.mapbox.com/directions/v5';
  final String _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final String _apiKey =
      'pk.eyJ1IjoidGhlYWxsciIsImEiOiJja29iczc0cG0wYm50MnFuMjRrbXhldHNyIn0.3PZmSmG12j4JlmylhB-xgA';

  Future<DrivingResponse> getStartAndEndCoordinates(
      LatLng start, LatLng end) async {
    final coordString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '${this._baseUrl}/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }

  Future<SearchMapResponse> getResultsByQuery(
      String search, LatLng proximity) async {
    final url = '${this._baseUrlGeo}/mapbox.places/$search.json';

    try {
      final resp = await this._dio.get(url, queryParameters: {
        'access_token': this._apiKey,
        'autocomplete': 'true',
        'proximity': ' ${proximity.longitude}, ${proximity.latitude}',
        'language': 'es',
      });

      final searchResponse = searchMapResponseFromJson(resp.data);

      return searchResponse;
    } catch (e) {
      return SearchMapResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResultsByQuery(value!, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<ReverseQueryResponse> getCoordsInfo(LatLng destinationCoords) async {
    final url =
        '${this._baseUrlGeo}/mapbox.places/${destinationCoords.longitude},${destinationCoords.latitude}.json';
    final resp = await this._dio.get(url, queryParameters: {
      'access_token': this._apiKey,
      'language': 'es',
    });

    final data = reverseQueryResponseFromJson(resp.data);
    return data;
  }

  Future<bool> getStations() async {
    final token = await this._storage.read(key: 'token');
    if (token == null) return false;
    _dio.options.headers["Authorization"] = "Bearer " + token;
    final resp = await _dio.get('${Environment.apiUrl}/stations');

    if (!validateStatus(resp)) {
      return false;
    }

    if (resp.data['ok']) {
      //print(resp.data);
      this.stationsList = StationsListResponse.fromJson(resp.data);
      return true;
    } else {
      this.error = ErrorResponse.fromJson(resp.data);
      //this.logout();
      return false;
    }
  }

  Future<GasolinePricesResponse> getStationsPrices(String id) async {
    final token = await this._storage.read(key: 'token');
    if (token == null) return GasolinePricesResponse(ok: false, prices: null);
    _dio.options.headers["Authorization"] = "Bearer " + token;
    final resp = await _dio
        .get('${Environment.apiUrl}/prices', queryParameters: {'id': id});
    //print('${Environment.apiUrl}/prices  params:$id');
    if (!validateStatus(resp)) {
      return GasolinePricesResponse(ok: false, prices: null);
    }

    if (resp.data['ok']) {
      //this.stationsList = StationsListResponse.fromJson(resp.data);
      this.prices = GasolinePricesResponse.fromJson(resp.data);
      print(resp.data);
      //print(prices.prices.regular);
      return prices!;
      //return true;
    } else {
      //this.error = ErrorResponse.fromJson(resp.data);
      //this.logout();
      return GasolinePricesResponse(ok: false, prices: null);
    }
  }

  bool validateStatus(Response<dynamic> data) {
    if (data.statusCode == 200) {
      return true;
    } else if (data.statusCode! >= 500) {
      return false;
    } else {
      return false;
    }
  }
}
