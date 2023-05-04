// To parse this JSON data, do
//
//     final bannerModal = bannerModalFromJson(jsonString);

import 'dart:convert';

BannerModal bannerModalFromJson(String str) => BannerModal.fromJson(json.decode(str));

String bannerModalToJson(BannerModal data) => json.encode(data.toJson());

class BannerModal {
  int status;
  String message;
  List<BannerModalDatum> data;

  BannerModal({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BannerModal.fromJson(Map<String, dynamic> json) => BannerModal(
    status: json["status"],
    message: json["message"],
    data: List<BannerModalDatum>.from(json["data"].map((x) => BannerModalDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BannerModalDatum {
  String id;
  String photo;
  String heading;
  String content;
  String buttonText;
  String buttonUrl;
  String subText;
  String status;
  String sType;

  BannerModalDatum({
    required this.id,
    required this.photo,
    required this.heading,
    required this.content,
    required this.buttonText,
    required this.buttonUrl,
    required this.subText,
    required this.status,
    required this.sType,
  });

  factory BannerModalDatum.fromJson(Map<String, dynamic> json) => BannerModalDatum(
    id: json["id"],
    photo: json["photo"],
    heading: json["heading"],
    content: json["content"],
    buttonText: json["button_text"],
    buttonUrl: json["button_url"],
    subText: json["sub_text"],
    status: json["status"],
    sType: json["s_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photo": photo,
    "heading": heading,
    "content": content,
    "button_text": buttonText,
    "button_url": buttonUrl,
    "sub_text": subText,
    "status": status,
    "s_type": sType,
  };
}
