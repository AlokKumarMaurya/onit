// To parse this JSON data, do
//
//     final allBuyServiceModal = allBuyServiceModalFromJson(jsonString);

import 'dart:convert';

AllBuyServiceModal allBuyServiceModalFromJson(String str) =>
    AllBuyServiceModal.fromJson(json.decode(str));

String allBuyServiceModalToJson(AllBuyServiceModal data) =>
    json.encode(data.toJson());

class AllBuyServiceModal {
  int status;
  String message;
  List<Datum> data;

  AllBuyServiceModal({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllBuyServiceModal.fromJson(Map<String, dynamic> json) =>
      AllBuyServiceModal(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String title;
  String slug;
  String image;

  Datum({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "image": image,
      };
}
