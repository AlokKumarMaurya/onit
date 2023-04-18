import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../api config/network_utility.dart';
import '../../api config/onit_url.dart';
import '../../model/forget_password_model.dart';
import '../../model/registration_Model.dart';
import '../../model/reset_pass.dart';

class RegistrationRepo {
  Future<RegistrationModel?> Register(
      {required String email,
      required String password,
      required String phoneNumber,
      required String name}) async {
    await NetworkUtility.checkNetworkStatus();
    try {
      Map mapData = {
        "email": email,
        "name": name,
        "phone": phoneNumber,
        "password": password
      };

      var response =
          await http.post(Uri.parse(OnitUrl.register), body: mapData);
      print("sendOtpResponse: ${response.body}");
      if (response.statusCode == 200) {
        return RegistrationModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<ForgetPasswordModel?> verifyOtp(
      {required String username,
      required String otp,
      }) async {
    await NetworkUtility.checkNetworkStatus();
    try {
      Map mapData = {
        "username": username,
        "otp": otp,

      };

      var response =
          await http.post(Uri.parse(OnitUrl.verifyOtp), body: mapData);
      print("verifyOtpResponse: ${response.body}");
      if (response.statusCode == 200) {
        return ForgetPasswordModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  Future<ForgetPasswordModel?> forgetPassword(
      {required String username,

      }) async {
    print(username);
    await NetworkUtility.checkNetworkStatus();
    try {
      Map mapData = {
        "username": username,
      };

      var response =
          await http.post(Uri.parse(OnitUrl.forgetPassword), body: mapData);
      print("forgetEmailResponse: ${response.body}");
      if (response.statusCode == 200) {

        return ForgetPasswordModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }




  Future<ResetPasswordModel?> SetNewPassword(
      {required String username,

      }) async {
    print(username);
    await NetworkUtility.checkNetworkStatus();
    try {
      Map mapData = {
        "username": username,
      };

      var response =
      await http.post(Uri.parse(OnitUrl.forgetPassword), body: mapData);
      print("forgetEmailResponse: ${response.body}");
      if (response.statusCode == 200) {

        return ResetPasswordModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  Future<ResetPasswordModel?> verifyResetOtp(
      {required String username,
        required String otp,
      }) async {
    await NetworkUtility.checkNetworkStatus();
    try {
      Map mapData = {
        "username": username,
        "otp": otp,

      };

      var response =
      await http.post(Uri.parse(OnitUrl.verifyOtp), body: mapData);
      print("verifyOtpResponse: ${response.body}");
      if (response.statusCode == 200) {
        return ResetPasswordModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  SendResetPasswordOtp(String a)async{
    await  NetworkUtility.checkNetworkStatus();
    try{
      var body={
        "username":a
      };
      var res=await http.post(Uri.parse(OnitUrl.forgetPassword),body: body);
      if(res.statusCode==200){
        ResetOtpsend modal=ResetOtpsend.fromJson(jsonDecode(res.body));
return modal;
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
    
    
    
    
  }



}





// To parse this JSON data, do
//
//     final resetOtpsend = resetOtpsendFromJson(jsonString);



ResetOtpsend resetOtpsendFromJson(String str) => ResetOtpsend.fromJson(json.decode(str));

String resetOtpsendToJson(ResetOtpsend data) => json.encode(data.toJson());

class ResetOtpsend {
  ResetOtpsend({
   required this.status,
   required this.message,
   required this.data,
  });

  int status;
  String message;
  int data;

  factory ResetOtpsend.fromJson(Map<String, dynamic> json) => ResetOtpsend(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
