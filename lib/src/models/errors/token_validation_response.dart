// To parse this JSON data, do
//
//     final tokenValidationResponse = tokenValidationResponseFromJson(jsonString);

import 'dart:convert';

TokenValidationResponse tokenValidationResponseFromJson(String str) =>
    TokenValidationResponse.fromJson(json.decode(str));

String tokenValidationResponseToJson(TokenValidationResponse data) =>
    json.encode(data.toJson());

class TokenValidationResponse {
  TokenValidationResponse({
    this.ok,
    this.code,
    this.message,
  });

  bool? ok;
  int? code;
  String? message;

  factory TokenValidationResponse.fromJson(Map<String, dynamic> json) =>
      TokenValidationResponse(
        ok: json["ok"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "code": code,
        "message": message,
      };
}
