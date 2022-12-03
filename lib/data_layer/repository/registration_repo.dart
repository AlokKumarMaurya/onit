import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../api config/network_utility.dart';
import '../../api config/onit_url.dart';
import '../../model/forget_password_model.dart';
import '../../model/registration_Model.dart';

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





}
