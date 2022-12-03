// To parse this JSON data, do
//
//     final getUserOtherModel = getUserOtherModelFromJson(jsonString);

import 'dart:convert';

GetUserOtherModel getUserOtherModelFromJson(String str) => GetUserOtherModel.fromJson(json.decode(str));

String getUserOtherModelToJson(GetUserOtherModel data) => json.encode(data.toJson());

class GetUserOtherModel {
  GetUserOtherModel({
  required this.status,
  required this.message,
  required this.remark,
  required this.userOtherData,
  });

  int status;
  String message;
  String remark;
  List<UserOtherDatum> userOtherData;

  factory GetUserOtherModel.fromJson(Map<String, dynamic> json) => GetUserOtherModel(
    status: json["status"],
    message: json["message"],
    remark: json["remark"],
    userOtherData: List<UserOtherDatum>.from(json["data"].map((x) => UserOtherDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "remark": remark,
    "data": List<dynamic>.from(userOtherData.map((x) => x.toJson())),
  };
}

class UserOtherDatum {
  UserOtherDatum({
   required this.dataId,
   required this.userId,
   required this.typeId,
   required this.value,
   required this.createdAt,
   required this.title,
   required this.status,
   required this.type,
   required this.odBy,
  });

  String dataId;
  String userId;
  String typeId;
  String value;
  String createdAt;
  String title;
  String status;
  String type;
  String odBy;

  factory UserOtherDatum.fromJson(Map<String, dynamic> json) => UserOtherDatum(
    dataId: json["data_id"],
    userId: json["user_id"],
    typeId: json["type_id"],
    value: json["value"],
    createdAt: json["created_at"],
    title: json["title"],
    status: json["status"],
    type: json["type"],
    odBy: json["od_by"],
  );

  Map<String, dynamic> toJson() => {
    "data_id": dataId,
    "user_id": userId,
    "type_id": typeId,
    "value": value,
    "created_at": createdAt,
    "title": title,
    "status": status,
    "type": type,
    "od_by": odBy,
  };
}
