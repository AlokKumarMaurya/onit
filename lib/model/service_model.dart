// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  int status;
  String message;
  String serviceCharge;
  List<ServiceData> data;

  ServiceModel({
    required this.status,
    required this.message,
    required this.serviceCharge,
    required this.data,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        status: json["status"],
        message: json["message"],
        serviceCharge: json["service_charge"],
        data: List<ServiceData>.from(
            json["data"].map((x) => ServiceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "service_charge": serviceCharge,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ServiceData {
  String sId;
  String catId;
  String title;
  String content;
  String price;
  String featured;
  String image;
  String status;
  DateTime fromDate;
  DateTime toDate;
  DateTime createdAt;
  DateTime updatedAt;

  ServiceData({
    required this.sId,
    required this.catId,
    required this.title,
    required this.content,
    required this.price,
    required this.featured,
    required this.image,
    required this.status,
    required this.fromDate,
    required this.toDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
        sId: json["s_id"],
        catId: json["cat_id"],
        title: json["title"],
        content: json["content"],
        price: json["price"],
        featured: json["featured"],
        image: json["image"],
        status: json["status"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "s_id": sId,
        "cat_id": catId,
        "title": title,
        "content": content,
        "price": price,
        "featured": featured,
        "image": image,
        "status": status,
        "from_date":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
