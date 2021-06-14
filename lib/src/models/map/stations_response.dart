// To parse this JSON data, do
//
//     final stationsListResponse = stationsListResponseFromJson(jsonString);

import 'dart:convert';

StationsListResponse stationsListResponseFromJson(String str) =>
    StationsListResponse.fromJson(json.decode(str));

String stationsListResponseToJson(StationsListResponse data) =>
    json.encode(data.toJson());

class StationsListResponse {
  StationsListResponse({
    this.ok,
    this.stations,
  });

  bool? ok;
  List<Station>? stations;

  factory StationsListResponse.fromJson(Map<String, dynamic> json) =>
      StationsListResponse(
        ok: json["ok"],
        stations: List<Station>.from(
            json["stations"].map((x) => Station.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "stations": List<dynamic>.from(stations!.map((x) => x.toJson())),
      };
}

class Station {
  Station({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.latitude,
    this.longitude,
  });

  int? id;
  String? name;
  String? address;
  String? phone;
  String? email;
  String? latitude;
  String? longitude;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
      };
}
