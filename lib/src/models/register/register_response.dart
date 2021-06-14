// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.ok,
    this.code,
    this.message,
  });

  bool? ok;
  int? code;
  Message? message;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        ok: json["ok"],
        code: json["code"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "code": code,
        "message": message!.toJson(),
      };
}

class Message {
  Message({
    this.name,
    this.firstSurname,
    this.secondSurname,
    this.email,
    this.password,
    this.phone,
    this.birthdate,
    this.sex,
  });

  List<String>? name;
  List<String>? firstSurname;
  List<String>? secondSurname;
  List<String>? email;
  List<String>? password;
  List<String>? phone;
  List<String>? birthdate;
  List<String>? sex;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        name: (json["name"] is List)
            ? List<String>.from(json["name"].map((x) => x))
            : [],
        firstSurname: (json["first_surname"] is List)
            ? List<String>.from(json["first_surname"].map((x) => x))
            : [],
        secondSurname: (json["second_surname"] is List)
            ? List<String>.from(json["second_surname"].map((x) => x))
            : [],
        email: (json["email"] is List)
            ? List<String>.from(json["email"].map((x) => x))
            : [],
        password: (json["password"] is List)
            ? List<String>.from(json["password"].map((x) => x))
            : [],
        phone: (json["phone"] is List)
            ? List<String>.from(json["phone"].map((x) => x))
            : [],
        birthdate: (json["birthdate"] is List)
            ? List<String>.from(json["birthdate"].map((x) => x))
            : [],
        sex: (json["sex"] is List)
            ? List<String>.from(json["sex"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "name": List<dynamic>.from(name!.map((x) => x)),
        "first_surname": List<dynamic>.from(firstSurname!.map((x) => x)),
        "second_surname": List<dynamic>.from(secondSurname!.map((x) => x)),
        "email": List<dynamic>.from(email!.map((x) => x)),
        "password": List<dynamic>.from(password!.map((x) => x)),
        "phone": List<dynamic>.from(phone!.map((x) => x)),
        "birthdate": List<dynamic>.from(birthdate!.map((x) => x)),
        "sex": List<dynamic>.from(sex!.map((x) => x)),
      };
}
