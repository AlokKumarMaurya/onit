
import 'dart:convert';
import 'dart:io';

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





Future<String>  uploadDocNew(File? file , int type)async{
    debugPrint("00000000000000000000000000000000000000000");
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      )
    );
    String profileHash = AppPreference().profileHash;
    debugPrint("00000000000000000000000000000000000000000");
    debugPrint(profileHash);
    if(file==null || file!.path.isEmpty){
    Get.showSnackbar(GetSnackBar(messageText:  Text("Chosse file first",style: TextStyle(
      color: Colors.white
    ),),
      backgroundColor: Colors.red,
      duration: Duration(
      seconds: 2
    ),));

        Get.back();
    }else{
      final postBody = FormData({
        "profile_hash":profileHash,
        "doc_type":type,
        "file":  MultipartFile(file, filename: file.path.split("/").last.toString()),
      });

      try{
       var response=await post((OnitUrl.uploadDoucment), postBody);
       debugPrint(response.statusCode.toString());
       debugPrint(response.body.toString());
      if(response.statusCode==200){
        // var temp=jsonDecode(response.body);
        debugPrint(response.body["message"]);
        Get.back();
        Get.back();
        Fluttertoast.showToast(msg:response.body["message"] );
return "sdds";
      }
      return "sds";
      }catch(e){
        debugPrint(e.toString());
        Get.showSnackbar(GetSnackBar(messageText:  Text(e.toString(),style: TextStyle(
            color: Colors.white
        ),),
          backgroundColor: Colors.red,
          duration: Duration(
              seconds: 2
          ),));
        return "dfm,";
      }
// Get.back();
    }
    return "sdmm";
    // Get.back();
  }


  changePassWord(String pass)async{
    var profileHash=AppPreference().profileHash;
    debugPrint("0000000000000000000000000");
    debugPrint(pass);
    debugPrint(profileHash);
    var body={
      "profile_hash":profileHash,
      "password":pass
    };
    try{
      var response=await http.post(Uri.parse(OnitUrl.resetPassword),body:body);
      if(response.statusCode==200){
        debugPrint(response.body.toString());
        var temp=jsonDecode(response.body);
        debugPrint("9389487934787983984093849283-----------------------");
        debugPrint(temp["message"].toString());
        return temp["message"];
      }
    }catch(e){
      debugPrint(e.toString());
      debugPrint("=======================");
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}