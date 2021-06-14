// To parse this JSON data, do
//
//     final contactListResponse = contactListResponseFromJson(jsonString);

import 'dart:convert';

ContactListResponse contactListResponseFromJson(String str) =>
    ContactListResponse.fromJson(json.decode(str));

String contactListResponseToJson(ContactListResponse data) =>
    json.encode(data.toJson());

class ContactListResponse {
  ContactListResponse({
    this.ok,
    this.partners,
  });

  bool? ok;
  List<PartnerL>? partners;

  factory ContactListResponse.fromJson(Map<String, dynamic> json) =>
      ContactListResponse(
        ok: json["ok"],
        partners: List<PartnerL>.from(
            json["partners"].map((x) => PartnerL.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "partners": List<dynamic>.from(partners!.map((x) => x.toJson())),
      };
}

class PartnerL {
  PartnerL({
    this.clientId,
    this.userId,
    this.membership,
    this.name,
  });

  int? clientId;
  int? userId;
  String? membership;
  String? name;

  factory PartnerL.fromJson(Map<String, dynamic> json) => PartnerL(
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
