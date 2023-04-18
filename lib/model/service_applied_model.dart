// To parse this JSON data, do
//
//     final serviceAppliedModel = serviceAppliedModelFromJson(jsonString);

import 'dart:convert';

ServiceAppliedModel serviceAppliedModelFromJson(String str) => ServiceAppliedModel.fromJson(json.decode(str));

String serviceAppliedModelToJson(ServiceAppliedModel data) => json.encode(data.toJson());

class ServiceAppliedModel {
  ServiceAppliedModel({
  required  this.status,
  required  this.message,
  required  this.serviceAppliedList,
  });

  int status;
  String message;
  List<ServiceAppliedList> serviceAppliedList;

  factory ServiceAppliedModel.fromJson(Map<String, dynamic> json) => ServiceAppliedModel(
    status: json["status"],
    message: json["message"],
    serviceAppliedList: List<ServiceAppliedList>.from(json["data"].map((x) => ServiceAppliedList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(serviceAppliedList.map((x) => x.toJson())),
  };
}

class ServiceAppliedList {
  ServiceAppliedList({
  required this.id,
  required this.serviceId,
  required this.userId,
  required this.paymentId,
  required this.amount,
  required this.paymentMethod,
  required this.paymentStatus,
  required this.serviceStatus,
  required this.remark,
  required this.createdAt,
  required this.updatedAt,
  required this.sId,
  required this.title,
  required this.content,
  required this.price,
  required this.featured,
  required this.image,
  required this.status,
  });

  String id;
  String serviceId;
  String userId;
  String paymentId;
  String amount;
  String paymentMethod;
  String paymentStatus;
  String serviceStatus;
  String remark;
  String createdAt;
  String updatedAt;
  String sId;
  String title;
  String content;
  String price;
  String featured;
  String image;
  String status;

  factory ServiceAppliedList.fromJson(Map<String, dynamic> json) => ServiceAppliedList(
    id: json["id"],
    serviceId: json["service_id"],
    userId: json["user_id"],
    paymentId: json["payment_id"],
    amount: json["amount"],
    paymentMethod: json["payment_method"],
    paymentStatus: json["payment_status"],
    serviceStatus: json["service_status"],
    remark: json["remark"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    sId: json["s_id"],
    title: json["title"],
    content: json["content"],
    price: json["price"],
    featured: json["featured"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_id": serviceId,
    "user_id": userId,
    "payment_id": paymentId,
    "amount": amount,
    "payment_method": paymentMethod,
    "payment_status": paymentStatus,
    "service_status": serviceStatus,
    "remark": remark,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "s_id": sId,
    "title": title,
    "content": content,
    "price": price,
    "featured": featured,
    "image": image,
    "status": status,
  };
}
