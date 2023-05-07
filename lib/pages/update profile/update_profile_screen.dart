import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/api%20config/api_client.dart';

import '../../component/shimmer.dart';
import '../../component/text_form_field.dart';
import '../../data_layer/repository/homePageRepository.dart';
import '../../model/get_user_details.dart';
import '../../utilities/app_nav.dart';
import '../../utilities/app_routes.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateProfileScreen> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _fatherName = TextEditingController();
  final _motherName = TextEditingController();
  final _permanentAddress = TextEditingController();
  final _currentAddress = TextEditingController();

  GetUserDetailsModel? get_user_data_model;

  List<UserDatum> userData = [];
bool isloading=false;
  getUserData() async {
    var userDataResponse = await HomeRepository().getUserDetails();
    if (userDataResponse != null) {
      setState(() {
        get_user_data_model = userDataResponse;
        if (get_user_data_model?.status == 1) {
          userData = get_user_data_model?.userData ?? [];
          if(userData!.length!=0){
            _email.text = userData[0].email.toString();
            _name.text = userData[0].name.toString();
            _phone.text = userData[0].phone.toString();
            _fatherName.text = userData[0].fatherName.toString();
            _motherName.text = userData[0].motherName.toString();
            _permanentAddress.text = userData[0].permanentAddress.toString();
            _currentAddress.text = userData[0].currentAddress.toString();
          }else{

            _email.text = "";
            _name.text = "";
            _phone.text = "";
            _fatherName.text = "";
            _motherName.text ="";
            _permanentAddress.text = "";
            _currentAddress.text = "";

          }

        } else {
          Fluttertoast.showToast(msg: get_user_data_model!.message);
        }
      });
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            const Text(
              "Enter Your Personal Details Properly",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
                child: get_user_data_model != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Your Name"),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            cotroller: _name,
                            hintText:  _name.text!= ""
                                ? "${userData[0].name}"
                                : "Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Your Email"),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            cotroller: _email,
                            hintText:  _email.text!= ""
                                ? "${userData[0].email}":"Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Your Phone"),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            readonly: true,
                            cotroller: _phone,
                            hintText: _phone.text!= ""
                                ? "${userData[0].phone}":"Phone",
                            prefixIcon: Icon(
                              Icons.settings_cell,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Father Name"),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            readonly: true,
                            cotroller: _fatherName,
                            hintText: _fatherName.text!= ""
                                ? "${userData[0].fatherName??"Father Name"}":"Father Name",
                            prefixIcon: Icon(
                              Icons.person_outline_outlined,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Mother Name"),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            readonly: true,
                            cotroller: _motherName,
                            hintText: _motherName.text!= ""
                                ? "${userData[0].motherName??"Mother name"}":"Mother Name",
                            prefixIcon: Icon(
                              Icons.family_restroom,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Permanent Address"),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            readonly: true,
                            cotroller: _permanentAddress,
                            hintText: _permanentAddress.text!= ""
                                ? "${userData[0].permanentAddress??"Permanent Address"}":"Permanent Address",
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Current Address"),
                          const SizedBox(
                            height: 10,
                          ),
                          textFormField(
                            readonly: true,
                            cotroller: _currentAddress,
                            hintText: _currentAddress.text!= ""
                                ? "${userData[0].currentAddress??"Current Address"}":"Current Address",
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : const ShimmerWidget(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),

                        //////// HERE
                      ),
                      onPressed: () {
                       // update();
                      },
                      child: Text("Update")),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

/*  void update() async{
    Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      content: CircularProgressIndicator()
    );
   var res=await ApiClient().UpdateUserProfile(_name.text,_email.text,_phone.text);
   if(res !=null){
     Get.back();
   }
  }*/
}
