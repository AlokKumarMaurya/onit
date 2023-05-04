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
  List<DatumOfAllBuyServiceList> data;

  AllBuyServiceModal({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllBuyServiceModal.fromJson(Map<String, dynamic> json) =>
      AllBuyServiceModal(
        status: json["status"],
        message: json["message"],
        data: List<DatumOfAllBuyServiceList>.from(
            json["data"].map((x) => DatumOfAllBuyServiceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumOfAllBuyServiceList {
  String id;
  String title;
  String slug;

  DatumOfAllBuyServiceList({
    required this.id,
    required this.title,
    required this.slug,
  });

  factory DatumOfAllBuyServiceList.fromJson(Map<String, dynamic> json) =>
      DatumOfAllBuyServiceList(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
      };
}
