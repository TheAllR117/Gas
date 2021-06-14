// To parse this JSON data, do
//
//     final depositResponse = depositResponseFromJson(jsonString);

import 'dart:convert';

DepositResponse depositResponseFromJson(String str) =>
    DepositResponse.fromJson(json.decode(str));

String depositResponseToJson(DepositResponse data) =>
    json.encode(data.toJson());

class DepositResponse {
  DepositResponse({
    this.ok,
    this.deposits,
  });

  bool? ok;
  List<Deposit>? deposits;

  factory DepositResponse.fromJson(Map<String, dynamic> json) =>
      DepositResponse(
        ok: json["ok"],
        deposits: List<Deposit>.from(
            json["deposits"].map((x) => Deposit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "deposits": List<dynamic>.from(deposits!.map((x) => x.toJson())),
      };
}

class Deposit {
  Deposit({
    this.balance,
    this.date,
    this.hour,
  });

  int? balance;
  DateTime? date;
  String? hour;

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        balance: json["balance"],
        date: DateTime.parse(json["date"]),
        hour: json["hour"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "hour": hour,
      };
}
