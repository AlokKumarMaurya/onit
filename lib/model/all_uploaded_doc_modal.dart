// To parse this JSON data, do
//
//     final uploadedDocumentModal = uploadedDocumentModalFromJson(jsonString);

import 'dart:convert';

UploadedDocumentModal uploadedDocumentModalFromJson(String str) => UploadedDocumentModal.fromJson(json.decode(str));

String uploadedDocumentModalToJson(UploadedDocumentModal data) => json.encode(data.toJson());

class UploadedDocumentModal {
  UploadedDocumentModal({
    required this.status,
    required this.message,
    required this.remark,
    required this.data,
  });

  int status;
  String message;
  String? remark;
  List<Datum> data;

  factory UploadedDocumentModal.fromJson(Map<String, dynamic> json) => UploadedDocumentModal(
    status: json["status"],
    message: json["message"],
    remark: json["remark"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "remark": remark,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.docId,
    required this.docType,
    required this.fileName,
    required this.userId,
    required this.uploadedAt,
    required this.typeId,
    required this.title,
    required this.status,
    required this.type,
    required this.odBy,
   required this.createdAt,
  });

  String docId;
  String docType;
  String fileName;
  String userId;
  DateTime uploadedAt;
  String typeId;
  String title;
  String status;
  String type;
  String odBy;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    docId: json["doc_id"],
    docType: json["doc_type"],
    fileName: json["file_name"],
    userId: json["user_id"],
    uploadedAt: DateTime.parse(json["uploaded_at"]),
    typeId: json["type_id"],
    title: json["title"],
    status: json["status"],
    type: json["type"],
    odBy: json["od_by"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "doc_id": docId,
    "doc_type": docType,
    "file_name": fileName,
    "user_id": userId,
    "uploaded_at": uploadedAt.toIso8601String(),
    "type_id": typeId,
    "title": title,
    "status": status,
    "type": type,
    "od_by": odBy,
    "created_at": createdAt.toIso8601String(),
  };
}
