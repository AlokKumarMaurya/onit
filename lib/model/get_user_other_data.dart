// To parse this JSON data, do
//
//     final getUserOtherModel = getUserOtherModelFromJson(jsonString);

import 'dart:convert';

GetUserOtherModel getUserOtherModelFromJson(String str) => GetUserOtherModel.fromJson(json.decode(str));

String getUserOtherModelToJson(GetUserOtherModel data) => json.encode(data.toJson());

class GetUserOtherModel {
  int status;
  String message;
  String remark;
  Data data;

  GetUserOtherModel({
    required this.status,
    required this.message,
    required this.remark,
    required this.data,
  });

  factory GetUserOtherModel.fromJson(Map<String, dynamic> json) => GetUserOtherModel(
    status: json["status"],
    message: json["message"],
    remark: json["remark"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "remark": remark,
    "data": data.toJson(),
  };
}

class Data {
  List<UserOtherDatum> data;

  Data({
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<UserOtherDatum>.from(json["data"].map((x) => UserOtherDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserOtherDatum {
  String typeId;
  String title;
  String status;
  String type;
  String isRequire;
  String odBy;
  DateTime createdAt;
  String value;

  UserOtherDatum({
    required this.typeId,
    required this.title,
    required this.status,
    required this.type,
    required this.isRequire,
    required this.odBy,
    required this.createdAt,
    required this.value,
  });

  factory UserOtherDatum.fromJson(Map<String, dynamic> json) => UserOtherDatum(
    typeId: json["type_id"],
    title: json["title"],
    status: json["status"],
    type: json["type"],
    isRequire: json["is_require"],
    odBy: json["od_by"],
    createdAt: DateTime.parse(json["created_at"]),
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type_id": typeId,
    "title": title,
    "status": status,
    "type": type,
    "is_require": isRequire,
    "od_by": odBy,
    "created_at": createdAt.toIso8601String(),
    "value": value,
  };
}
