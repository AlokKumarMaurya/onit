// To parse this JSON data, do
//
//     final getConfigModel = getConfigModelFromJson(jsonString);

import 'dart:convert';

GetConfigModel getConfigModelFromJson(String str) => GetConfigModel.fromJson(json.decode(str));

String getConfigModelToJson(GetConfigModel data) => json.encode(data.toJson());

class GetConfigModel {
  GetConfigModel({
   required this.status,
   required this.message,
   required this.data,
  });

  int status;
  String message;
  List<ConfigList> data;

  factory GetConfigModel.fromJson(Map<String, dynamic> json) => GetConfigModel(
    status: json["status"],
    message: json["message"],
    data: List<ConfigList>.from(json["data"].map((x) => ConfigList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ConfigList {
  ConfigList({
   required this.id,
  required this.name,
  required this.metaName,
  required this.metaDescription,
  required this.logo,
  required this.favicon,
  required this.contactAddress,
  required this.contactPhone,
  required this.email,
  required this.phone,
  required this.fax1,
  required this.fax2,
  required this.contactEmail,
  required this.currency,
  required this.footerCopyright,
  required this.preloadSec,
  required this.footerAbout,
  required this.preloadImg,
  required this.mapKey,
  required this.latitude,
  required this.longitude,
  required this.mntMode,
  required this.aboutUs,
  required this.aboutUsLink,
  required this.contactImage,
  required this.about1Link,
  required this.about1,
  required this.blogAmount,
    this.razorpayKey,
  });

  String id;
  String name;
  String metaName;
  String metaDescription;
  String logo;
  String favicon;
  String contactAddress;
  String contactPhone;
  String email;
  String phone;
  String fax1;
  String fax2;
  String contactEmail;
  String currency;
  String footerCopyright;
  String preloadSec;
  String footerAbout;
  String preloadImg;
  String mapKey;
  String latitude;
  String longitude;
  String mntMode;
  String aboutUs;
  String aboutUsLink;
  String contactImage;
  String about1Link;
  String about1;
  String blogAmount;
  dynamic razorpayKey;

  factory ConfigList.fromJson(Map<String, dynamic> json) => ConfigList(
    id: json["id"],
    name: json["name"],
    metaName: json["meta_name"],
    metaDescription: json["meta_description"],
    logo: json["logo"],
    favicon: json["favicon"],
    contactAddress: json["contact_address"],
    contactPhone: json["contact_phone"],
    email: json["email"],
    phone: json["phone"],
    fax1: json["fax1"],
    fax2: json["fax2"],
    contactEmail: json["contact_email"],
    currency: json["currency"],
    footerCopyright: json["footer_copyright"],
    preloadSec: json["preload_sec"],
    footerAbout: json["footer_about"],
    preloadImg: json["preload_img"],
    mapKey: json["map_key"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    mntMode: json["mnt_mode"],
    aboutUs: json["about_us"],
    aboutUsLink: json["about_us_link"],
    contactImage: json["contact_image"],
    about1Link: json["about1_link"],
    about1: json["about1"],
    blogAmount: json["blog_amount"],
    razorpayKey: json["razorpay_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "meta_name": metaName,
    "meta_description": metaDescription,
    "logo": logo,
    "favicon": favicon,
    "contact_address": contactAddress,
    "contact_phone": contactPhone,
    "email": email,
    "phone": phone,
    "fax1": fax1,
    "fax2": fax2,
    "contact_email": contactEmail,
    "currency": currency,
    "footer_copyright": footerCopyright,
    "preload_sec": preloadSec,
    "footer_about": footerAbout,
    "preload_img": preloadImg,
    "map_key": mapKey,
    "latitude": latitude,
    "longitude": longitude,
    "mnt_mode": mntMode,
    "about_us": aboutUs,
    "about_us_link": aboutUsLink,
    "contact_image": contactImage,
    "about1_link": about1Link,
    "about1": about1,
    "blog_amount": blogAmount,
    "razorpay_key": razorpayKey,
  };
}
