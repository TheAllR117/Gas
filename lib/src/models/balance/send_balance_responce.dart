// To parse this JSON data, do
//
//     final sendBalanceResponse = sendBalanceResponseFromJson(jsonString);

import 'dart:convert';

SendBalanceResponse sendBalanceResponseFromJson(String str) =>
    SendBalanceResponse.fromJson(json.decode(str));

String sendBalanceResponseToJson(SendBalanceResponse data) =>
    json.encode(data.toJson());

class SendBalanceResponse {
  SendBalanceResponse({
    this.ok,
    this.code,
    this.message,
  });

  bool? ok;
  int? code;
  dynamic message;

  factory SendBalanceResponse.fromJson(Map<String, dynamic> json) =>
      SendBalanceResponse(
        ok: json["ok"],
        code: json["code"],
        message: (json["message"] is Map)
            ? Message.fromJson(json["message"])
            : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "code": code,
        "message": (message is String) ? message : message.toJson(),
      };
}

class Message {
  Message({
    this.balance,
  });

  List<String>? balance;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        balance: List<String>.from(json["balance"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "balance": List<dynamic>.from(balance!.map((x) => x)),
      };
}
