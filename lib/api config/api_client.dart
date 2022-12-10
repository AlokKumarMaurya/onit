
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
    print(name);
    print(email);
    // print(email);
    print(phone);
    print(profileHash);
    var body={
    "name":name,
    'email':email,
    "phone":phone,
    "profile_hash":profileHash
    };
    print(body);
    try{
      var response=await http.post(api,body: body);
      if(response.statusCode==200){
        print(response.body);
        return response;
      }
    }catch(e){

      Fluttertoast.showToast(msg: e.toString());
    }

  }


}