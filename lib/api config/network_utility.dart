import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'network_exception.dart';

class NetworkUtility {
  static Map responseHandler(Response responseJson) {
    if (responseJson.data is Map<String, dynamic>) {
      // valid response
      return responseJson.data;
    } else if (responseJson.data is String) {
      return jsonDecode(responseJson.data);
    } else {
      throw ServerException(responseJson.data);
    }
  }

  static Future<void> checkNetworkStatus() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        throw ConnectivityException();
      }
    } on SocketException catch (_) {
      throw ConnectivityException();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      throw ConnectivityException();
    }
  }
}
