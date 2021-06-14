// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.ok,
    this.user,
  });

  bool? ok;
  User? user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        ok: json["ok"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.name,
    this.membership,
    this.currentBalance,
    this.beneficiary,
  });

  String? name;
  String? membership;
  dynamic currentBalance;
  int? beneficiary;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        membership: json["membership"],
        currentBalance: json["current_balance"],
        beneficiary: json["beneficiary"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "membership": membership,
        "current_balance": currentBalance,
        "beneficiary": beneficiary,
      };
}
