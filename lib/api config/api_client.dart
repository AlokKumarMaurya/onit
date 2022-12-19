
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





  uploadDocNew(File? file)async{
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      )
    );
    String profileHash = AppPreference().profileHash;
    if(file==null || file!.path.isEmpty){
    Get.showSnackbar(GetSnackBar(messageText:  Text("Chosse file first",style: TextStyle(
      color: Colors.white
    ),),
      backgroundColor: Colors.red,
      duration: Duration(
      seconds: 2
    ),));
    }else{
      final postBody = FormData({
        "profile_hash":profileHash,
        "doc_type":1,
        "file":await  MultipartFile(file, filename: file.path.split("/").last.toString()),
      });

      try{
       var response=await post("https://onitonline.in/api/upload-user-file.php", postBody);
       debugPrint(response.statusCode.toString());
       Get.showSnackbar(GetSnackBar(messageText:  Text("status:${response.statusCode.toString()} body:${response.body.toString()}",style: TextStyle(
           color: Colors.white
       ),),
         backgroundColor: Colors.green,
         duration: Duration(
             seconds: 2
         ),));
      }catch(e){
        Get.showSnackbar(GetSnackBar(messageText:  Text(e.toString(),style: TextStyle(
            color: Colors.white
        ),),
          backgroundColor: Colors.red,
          duration: Duration(
              seconds: 2
          ),));
      }
Get.back();
    }
  }
}