// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
   required this.status,
   required this.message,
   required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.userId,
    required this.name,
    this.fatherName,
    this.motherName,
    this.permanentAddress,
    this.currentAddress,
  required  this.status,
  required  this.email,
  required  this.phone,
  required  this.password,
  required  this.token,
  required  this.profileHash,
  required  this.createdAt,
  required  this.updatedAt,
  });

  String userId;
  String name;
  dynamic fatherName;
  dynamic motherName;
  dynamic permanentAddress;
  dynamic currentAddress;
  String status;
  String email;
  String phone;
  String password;
  String token;
  String profileHash;
  String createdAt;
  String updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["user_id"],
    name: json["name"],
    fatherName: json["father_name"],
    motherName: json["mother_name"],
    permanentAddress: json["permanent_address"],
    currentAddress: json["current_address"],
    status: json["status"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    token: json["token"],
    profileHash: json["profile_hash"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "father_name": fatherName,
    "mother_name": motherName,
    "permanent_address": permanentAddress,
    "current_address": currentAddress,
    "status": status,
    "email": email,
    "phone": phone,
    "password": password,
    "token": token,
    "profile_hash": profileHash,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
