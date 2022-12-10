
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/api%20config/onit_url.dart';
import 'package:http/http.dart'as http;
import '../utilities/app_prefereces.dart';
import 'network_utility.dart';

class ApiClient extends GetConnect{
  UpdateUserProfile(String name,String email ,String phone)async{
    var api=Uri.parse(OnitUrl.updateProfile);
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;
    var body={
    "name":name,
    'email':email,
    "phone":phone,
    "profile_hash":profileHash
    };
    try{
      var response=await http.post(api,body: body);
      if(response.statusCode==200){
        print(response.body);
        return response;
      }
    }catch(e){Fluttertoast.showToast(msg: e.toString());}
  }



  UpdateUserOtherDetails(List data,List value)async{
    String profileHash = AppPreference().profileHash;
    String dataValue="";
    String keyValye='';
    for(int i=0;i<data.length;i++){
      dataValue=data[i]+","+dataValue;
      keyValye=value[i]+","+keyValye;
    }
    debugPrint(dataValue);
    debugPrint(keyValye);
    debugPrint(profileHash);
    try{
      var response=await http.post(Uri.parse(OnitUrl.updateOtherDetails),body: {
        "profile_hash":profileHash,
        "type_id[]":"$dataValue",
        "type_value[]":"$keyValye"
      });
      var aa=jsonDecode(response.body);
      // debugPrint(aa["message"].toString());
      // debugPrint("11111111111111111111111111111111111111");
      // debugPrint(response.body.toString());
      Fluttertoast.showToast(msg: aa["message"].toString());
      return aa["message"];

    }catch(e){Fluttertoast.showToast(msg: e.toString());}


debugPrint(dataValue);

  }



}