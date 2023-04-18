// To parse this JSON data, do
//
//     final passwordResetResponse = passwordResetResponseFromJson(jsonString);

import 'dart:convert';

PasswordResetResponse passwordResetResponseFromJson(String str) => PasswordResetResponse.fromJson(json.decode(str));

String passwordResetResponseToJson(PasswordResetResponse data) => json.encode(data.toJson());

class PasswordResetResponse {
  PasswordResetResponse({
  required this.status,
  required this.message,
  required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory PasswordResetResponse.fromJson(Map<String, dynamic> json) => PasswordResetResponse(
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
   required this.fatherName,
   required this.motherName,
   required this.permanentAddress,
   required this.currentAddress,
   required this.status,
   required this.email,
   required this.phone,
   required this.password,
   required this.token,
   required this.profileHash,
   required this.createdAt,
   required this.updatedAt,
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
  DateTime createdAt;
  DateTime updatedAt;

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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
