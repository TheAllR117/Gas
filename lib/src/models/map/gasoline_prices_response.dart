// To parse this JSON data, do
//
//     final gasolinePricesResponse = gasolinePricesResponseFromJson(jsonString);

import 'dart:convert';

GasolinePricesResponse gasolinePricesResponseFromJson(String str) =>
    GasolinePricesResponse.fromJson(json.decode(str));

String gasolinePricesResponseToJson(GasolinePricesResponse data) =>
    json.encode(data.toJson());

class GasolinePricesResponse {
  bool? ok;
  Prices? prices;
  GasolinePricesResponse({
    this.ok,
    this.prices,
  });

  factory GasolinePricesResponse.fromJson(Map<String, dynamic> json) =>
      GasolinePricesResponse(
        ok: json["ok"],
        prices: Prices.fromJson(json["prices"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "prices": prices!.toJson(),
      };
}

class Prices {
  double? regular;
  double? premium;
  double? diesel;

  Prices({
    this.regular,
    this.premium,
    this.diesel,
  });

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        regular: json["regular"] != null ? json["regular"].toDouble() : 0,
        premium: json["premium"] != null ? json["premium"].toDouble() : 0,
        diesel: json["diesel"] != null ? json["diesel"].toDouble() : 0,
      );

  Map<String, dynamic> toJson() => {
        "regular": regular,
        "premium": premium,
        "diesel": diesel,
      };
}
