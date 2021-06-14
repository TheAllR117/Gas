// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.ok,
    this.code,
    this.message,
  });

  bool? ok;
  int? code;
  String? message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
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
