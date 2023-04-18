import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logging/logging.dart';

import '../../api config/network_utility.dart';

import '../../api config/onit_url.dart';
import '../../model/login_model.dart';
import 'package:http/http.dart' as http;

import '../../model/password_reset_reset.dart';
import '../../utilities/app_prefereces.dart';

class LoginRepository {
  final logger = Logger("LoginRepository");

  Future<LoginModel?> Login(String username, String password) async {
    await NetworkUtility.checkNetworkStatus();
    print("test $username");
    try {
      Map mapData = {"username": username, "password": password};
      print("sendOtpPayload: $mapData");
      var response = await http.post(Uri.parse(OnitUrl.login), body: mapData);
      print("sendOtpResponse: ${response.body}");
      if (response.statusCode == 200) {
        return LoginModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      logger.info(e);
    }
  }


  ResetPassword(String pass, String hash)async{
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;
    try{
      var body={
        "profile_hash":hash,
        "password":pass
      };
      var res=await http.post(Uri.parse(OnitUrl.resetPassword),body: body);
      if(res.statusCode==200){
        PasswordResetResponse modal=PasswordResetResponse.fromJson(jsonDecode(res.body));
        return modal;
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }


}
