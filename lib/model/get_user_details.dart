// To parse this JSON data, do
//
//     final getUserDetailsModel = getUserDetailsModelFromJson(jsonString);

import 'dart:convert';

GetUserDetailsModel getUserDetailsModelFromJson(String str) => GetUserDetailsModel.fromJson(json.decode(str));

String getUserDetailsModelToJson(GetUserDetailsModel data) => json.encode(data.toJson());

class GetUserDetailsModel {
  GetUserDetailsModel({
   required this.status,
   required this.message,
   required this.userData,
  });

  int status;
  String message;
  List<UserDatum> userData;

  factory GetUserDetailsModel.fromJson(Map<String, dynamic> json) => GetUserDetailsModel(
    status: json["status"],
    message: json["message"],
    userData: List<UserDatum>.from(json["data"].map((x) => UserDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(userData.map((x) => x.toJson())),
  };
}

class UserDatum {
  UserDatum({
  required  this.userId,
  required  this.name,
  required  this.fatherName,
  required  this.motherName,
  required  this.permanentAddress,
  required  this.currentAddress,
  required  this.status,
  required  this.email,
  required  this.phone,
  required  this.password,
  required  this.token,
  required  this.profileHash,
  required  this.createdAt,
  required  this.updatedAt,
  });

  String? userId;
  String? name;
  String? fatherName;
  String? motherName;
  String? permanentAddress;
  String? currentAddress;
  String? status;
  String? email;
  String? phone;
  String? password;
  String? token;
  String? profileHash;
  String? createdAt;
  String? updatedAt;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
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
