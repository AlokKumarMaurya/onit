// To parse this JSON data, do
//
//     final getUserOtherModel = getUserOtherModelFromJson(jsonString);

import 'dart:convert';

GetUserOtherModel getUserOtherModelFromJson(String str) =>
    GetUserOtherModel.fromJson(json.decode(str));

String getUserOtherModelToJson(GetUserOtherModel data) =>
    json.encode(data.toJson());

class GetUserOtherModel {
  int status;
  String message;
  String remark;
  List<UserOtherDatum> data;

  GetUserOtherModel({
    required this.status,
    required this.message,
    required this.remark,
    required this.data,
  });

  factory GetUserOtherModel.fromJson(Map<String, dynamic> json) =>
      GetUserOtherModel(
        status: json["status"],
        message: json["message"],
        remark: json["remark"],
        data: List<UserOtherDatum>.from(
            json["data"].map((x) => UserOtherDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "remark": remark,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserOtherDatum {
  String dataId;
  String userId;
  String typeId;
  String value;
  DateTime createdAt;
  String title;
  String status;
  String isRequire;
  String type;
  String odBy;

  UserOtherDatum({
    required this.dataId,
    required this.userId,
    required this.typeId,
    required this.value,
    required this.createdAt,
    required this.title,
    required this.status,
    required this.isRequire,
    required this.type,
    required this.odBy,
  });

  factory UserOtherDatum.fromJson(Map<String, dynamic> json) => UserOtherDatum(
        dataId: json["data_id"],
        userId: json["user_id"],
        typeId: json["type_id"],
        value: json["value"],
        createdAt: DateTime.parse(json["created_at"]),
        title: json["title"],
        status: json["status"],
        isRequire: json["is_require"],
        type: json["type"],
        odBy: json["od_by"],
      );

  Map<String, dynamic> toJson() => {
        "data_id": dataId,
        "user_id": userId,
        "type_id": typeId,
        "value": value,
        "created_at": createdAt.toIso8601String(),
        "title": title,
        "status": status,
        "is_require": isRequire,
        "type": type,
        "od_by": odBy,
      };
}
