// To parse this JSON data, do
//
//     final contacSearchResponse = contacSearchResponseFromJson(jsonString);

import 'dart:convert';

ContacSearchResponse contacSearchResponseFromJson(String str) =>
    ContacSearchResponse.fromJson(json.decode(str));

String contacSearchResponseToJson(ContacSearchResponse data) =>
    json.encode(data.toJson());

class ContacSearchResponse {
  ContacSearchResponse({
    this.ok,
    this.partner,
  });

  bool? ok;
  Partner? partner;

  factory ContacSearchResponse.fromJson(Map<String, dynamic> json) =>
      ContacSearchResponse(
        ok: json["ok"],
        partner: Partner.fromJson(json["partner"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "partner": partner!.toJson(),
      };
}

class Partner {
  Partner({
    this.clientId,
    this.userId,
    this.membership,
    this.name,
  });

  int? clientId;
  int? userId;
  String? membership;
  String? name;

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
        clientId: json["client_id"],
        userId: json["user_id"],
        membership: json["membership"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "user_id": userId,
        "membership": membership,
        "name": name,
      };
}
