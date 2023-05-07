import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:onit/utilities/app_prefereces.dart';

import '../../api config/network_utility.dart';
import '../../api config/onit_url.dart';
import '../../model/get_config_model.dart';
import '../../model/get_doc_type_model.dart';
import '../../model/get_user_details.dart';
import '../../model/get_user_other_data.dart';
import '../../model/service_applied_model.dart';
import '../../model/service_model.dart';

class HomeRepository {
  final logger = Logger("Home Repository");

  Future<ServiceModel?> getService({required String catId}) async {
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;
    try {
      logger.info("profileHash: $profileHash");
      var response = await http.post(
          Uri.parse(OnitUrl.getService + profileHash),
          body: {"profile_hash": profileHash, "cat_id": catId});
      print("service Response: ${response.body}");
      if (response.statusCode == 200) {
        return ServiceModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  Future<ServiceAppliedModel?> servicesApplied() async {
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;

    try {
      Map<String, String>? mapData = {"profile_hash": profileHash};
   print("applied Service Payload:==> $mapData");
      var response =
          await http.post(Uri.parse(OnitUrl.appliedService), body: mapData);
      print("applied Service Response:==>  ${response.body}");
      if (response.statusCode == 200) {
        return ServiceAppliedModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  Future<GetConfigModel?> getConfig() async {
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;
    print(profileHash);
    Map mapData = {"profile_hash": profileHash};
    try {
      // print("get Config Payload:==> $mapData");
      var response =
          await http.post(Uri.parse(OnitUrl.getConfig), body: mapData);
      print("get Config Response:==>  ${response.body}");
      if (response.statusCode == 200) {
        return GetConfigModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  Future<GetUserDetailsModel?> getUserDetails() async {
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;
    print(profileHash);
    Map mapData = {"profile_hash": profileHash};
    try {
      // print("get Config Payload:==> $mapData");
      var response =
          await http.post(Uri.parse(OnitUrl.getUserDetails), body: mapData);
      print("get User Details Response:==>  ${response.body}");
      if (response.statusCode == 200) {
        return GetUserDetailsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  Future<GetUserOtherModel?> getUserOtherDetails() async {
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;
    print(profileHash);
    Map mapData = {"profile_hash": profileHash}; //"990665454534fsgh4d4h6edt4"

      print("getUserOtherDetailsPayload $mapData");
      var response =
          await http.post(Uri.parse(OnitUrl.getUserOther), body: mapData);
      print("get User Other Details Response:==>  ${OnitUrl.getUserOther}");
      print("get User Other Details Response:==>  ${response.body}");
      if (response.statusCode == 200) {
        return GetUserOtherModel.fromJson(jsonDecode(response.body));
      }

    return null;
  }

  Future<GetDocTypeModel?> getDocType() async {
    await NetworkUtility.checkNetworkStatus();
    String profileHash = AppPreference().profileHash;
    print("GetDocTypeModel$profileHash");
    Map mapData = {"profile_hash": profileHash};
    try {
      // print("get Config Payload:==> $mapData");
      var response =
          await http.post(Uri.parse(OnitUrl.getDocType), body: mapData);
      print("get Doc type Details Response:==>  ${response.body}");
      if (response.statusCode == 200) {
        return GetDocTypeModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
    return null;
  }
}
