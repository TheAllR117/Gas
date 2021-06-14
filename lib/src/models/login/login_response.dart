// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok,
    this.token,
    this.rol,
  });

  bool? ok;
  String? token;
  String? rol;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        token: json["token"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "token": token,
        "rol": rol,
      };
}
