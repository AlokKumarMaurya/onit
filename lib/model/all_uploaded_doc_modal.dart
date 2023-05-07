// To parse this JSON data, do
//
//     final uploadedDocumentModal = uploadedDocumentModalFromJson(jsonString);

import 'dart:convert';

UploadedDocumentModal uploadedDocumentModalFromJson(String str) => UploadedDocumentModal.fromJson(json.decode(str));

String uploadedDocumentModalToJson(UploadedDocumentModal data) => json.encode(data.toJson());

class UploadedDocumentModal {
  int status;
  String message;
  String remark;
  List<UploadDocDatum> data;

  UploadedDocumentModal({
    required this.status,
    required this.message,
    required this.remark,
    required this.data,
  });

  factory UploadedDocumentModal.fromJson(Map<String, dynamic> json) => UploadedDocumentModal(
    status: json["status"],
    message: json["message"],
    remark: json["remark"],
    data: List<UploadDocDatum>.from(json["data"].map((x) => UploadDocDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "remark": remark,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UploadDocDatum {
  String docId;
  String docType;
  String fileName;
  String userId;
  DateTime uploadedAt;
  String typeId;
  Title title;
  String status;
  String isRequire;
  String type;
  String odBy;
  DateTime createdAt;

  UploadDocDatum({
    required this.docId,
    required this.docType,
    required this.fileName,
    required this.userId,
    required this.uploadedAt,
    required this.typeId,
    required this.title,
    required this.status,
    required this.isRequire,
    required this.type,
    required this.odBy,
    required this.createdAt,
  });

  factory UploadDocDatum.fromJson(Map<String, dynamic> json) => UploadDocDatum(
    docId: json["doc_id"],
    docType: json["doc_type"],
    fileName: json["file_name"],
    userId: json["user_id"],
    uploadedAt: DateTime.parse(json["uploaded_at"]),
    typeId: json["type_id"],
    title: titleValues.map[json["title"]]!,
    status: json["status"],
    isRequire: json["is_require"],
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
    "title": titleValues.reverse[title],
    "status": status,
    "is_require": isRequire,
    "type": type,
    "od_by": odBy,
    "created_at": createdAt.toIso8601String(),
  };
}

enum Title { HIGH_SCHOOL_MARKSHEET, INTER_SCHOOL_MARKSHEET, AADHAAR_FRONT }

final titleValues = EnumValues({
  "Aadhaar (Front)": Title.AADHAAR_FRONT,
  "High School Marksheet": Title.HIGH_SCHOOL_MARKSHEET,
  "Inter School Marksheet": Title.INTER_SCHOOL_MARKSHEET
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
