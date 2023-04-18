// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
   required this.status,
   required this.message,
   required this.data,
  });

  int status;
  String message;
  List<ServiceData> data;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    status: json["status"],
    message: json["message"],
    data: List<ServiceData>.from(json["data"].map((x) => ServiceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ServiceData {
  ServiceData({
  required this.sId,
  required this.title,
  required this.content,
  required this.price,
  required this.featured,
  required this.image,
  required this.status,
  required this.createdAt,
  required this.updatedAt,
  });

  String sId;
  String title;
  String content;
  String price;
  String featured;
  String image;
  String status;
  String createdAt;
  String updatedAt;

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    sId: json["s_id"],
    title: json["title"],
    content: json["content"],
    price: json["price"],
    featured: json["featured"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "s_id": sId,
    "title": title,
    "content": content,
    "price": price,
    "featured": featured,
    "image": image,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
