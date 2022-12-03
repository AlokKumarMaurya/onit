// To parse this JSON data, do
//
//     final getDocTypeModel = getDocTypeModelFromJson(jsonString);

import 'dart:convert';

GetDocTypeModel getDocTypeModelFromJson(String str) => GetDocTypeModel.fromJson(json.decode(str));

String getDocTypeModelToJson(GetDocTypeModel data) => json.encode(data.toJson());

class GetDocTypeModel {
  GetDocTypeModel({
   required this.status,
   required this.message,
   required this.remark,
   required this.docType,
  });

  int status;
  String message;
  String remark;
  List<DocType> docType;

  factory GetDocTypeModel.fromJson(Map<String, dynamic> json) => GetDocTypeModel(
    status: json["status"],
    message: json["message"],
    remark: json["remark"],
    docType: List<DocType>.from(json["data"].map((x) => DocType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "remark": remark,
    "data": List<dynamic>.from(docType.map((x) => x.toJson())),
  };
}

class DocType {
  DocType({
  required this.typeId,
  required this.title,
  required this.status,
  required this.type,
  required this.odBy,
  required this.createdAt,
  });

  String typeId;
  String title;
  String status;
  String type;
  String odBy;
  String createdAt;

  factory DocType.fromJson(Map<String, dynamic> json) => DocType(
    typeId: json["type_id"],
    title: json["title"],
    status: json["status"],
    type: json["type"],
    odBy: json["od_by"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "type_id": typeId,
    "title": title,
    "status": status,
    "type": type,
    "od_by": odBy,
    "created_at": createdAt,
  };
}
