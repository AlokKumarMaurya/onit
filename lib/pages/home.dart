import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/data_layer/repository/homePageRepository.dart';
import 'package:onit/pages/Upload%20Doc/upload_doc_screen.dart';
import 'package:onit/pages/orders/orders_Screen.dart';
import 'package:onit/pages/other%20details/other_details_screen.dart';
import 'package:onit/pages/update%20profile/update_profile_screen.dart';
import 'package:onit/utilities/app_nav.dart';
import 'package:onit/utilities/app_routes.dart';


import '../api config/api_client.dart';
import '../component/app_tab_menu.dart';
import '../component/shimmer.dart';
import '../model/get_config_model.dart';
import '../model/get_doc_type_model.dart';
import '../model/get_user_details.dart';
import '../model/get_user_other_data.dart';
import '../model/service_applied_model.dart';
import '../model/service_model.dart';
import '../utilities/app_prefereces.dart';
import 'buy service/buy_service_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  bool services_loader = false;




  GetConfigModel? get_config_model;

  List<ConfigList> configDataList = [];

  getConfigs() async {
    setState(() {
      services_loader = true;
    });
    var configResponse = await HomeRepository().getConfig();
    if (configResponse != null) {
      setState(() {
        get_config_model = configResponse;
        if (get_config_model?.status == 1) {
          configDataList = get_config_model?.data ?? [];
          AppPreference().saveRazorPayKey(configDataList[0].razorpayKey ?? "");
        } else {
          Fluttertoast.showToast(msg: get_config_model!.message);
        }
        services_loader = false;
      });
    } else {
      setState(() {
        services_loader = false;
      });
    }
  }






  initApis() async {

    await getConfigs();

 }

  @override
  void initState() {
    initApis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Onit"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  
                  openDialog();
//logoutAlertBox();

                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: _buildTabChange(),
            ),
            Container(
              height: 80,
              child: AppTabMenu(
                menuItemsList: const [
                  "Service Asked",
                  "Forms",

                  "Update Profile", "Upload Doc",
                 // "Other Details",
                ],
                onItemClick: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedIndex: selectedIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabChange() {
    if (selectedIndex == 0) {
      return const OrderScreen();
    } else if (selectedIndex == 1) {
      return const BuyService();
    } else if (selectedIndex == 2) {
      return const   OtherDetailsScreen() ;
    } else if (selectedIndex == 3) {
      return const UploadDocScreen();
    }/* else if (selectedIndex == 4) {
      return const OtherDetailsScreen();
    }*/ else {
      return const OrderScreen();
    }
  }

  void logoutAlertBox() {

    Get.defaultDialog(
      title: "Logout",
      titleStyle:  TextStyle(
          fontSize: 22,color: Colors.black87,
          fontWeight: FontWeight.w500
      ),
      middleText: "Are you sure that you want to logout from Onit ",
      textCancel: "Cancel",
      textConfirm: "Logout",
      middleTextStyle: TextStyle(
        fontSize: 18,color: Colors.black87,
        fontWeight: FontWeight.w400
      ),

      cancel: InkWell(
        onTap: ()=>Navigator.pop(context),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text("Cancel",style:  TextStyle(
              fontSize: 20,color: Colors.black87,
              fontWeight: FontWeight.w500
          ),),width: MediaQuery.of(context).size.width/3.5,),
      ),
      confirm: InkWell(
        onTap: (){
          AppNav.offAllToNamed(AppRoutes.loginPage);
          AppPreference().saveLogin(false);
          AppPreference().saveRazorPayKey("");

          AppPreference().saveProfileHash("");
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text("Logout",style:  TextStyle(
              fontSize: 20,color: Colors.black87,
              fontWeight: FontWeight.w500
          ),),width: MediaQuery.of(context).size.width/3.5,),
      ) ,
      onCancel: () {
        print("cancledd clicked");
        Navigator.pop(context);
      },
      onConfirm: (){
      print("confirm clicked");
        AppNav.offAllToNamed(AppRoutes.loginPage);
        AppPreference().saveLogin(false);
        AppPreference().saveRazorPayKey("");

        AppPreference().saveProfileHash("");
    }
    );
    // Get.dialog(
    //   Container(
    //     height: 200,
    //     color: Colors.white24,
    //     child: Column(
    //       children: [
    //         Text("Logout"),
    //         SizedBox(height: 15,),
    //         Text("Are you sure that you want to logout"),
    //         SizedBox(height: 10,),
    //         Row(
    //           children: [
    //             TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel"))
    //           ],
    //         )
    //       ],
    //     ),
    //   )
    // );
  }
  
  void openDialog(){
    Get.bottomSheet(
      isScrollControlled: true,
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
        height: 100,
        // color:Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: (){
              Get.back();
              changePasswordSheet();
            }, child:Text("Change Password")),
            TextButton(onPressed: (){
              Get.back();
              logoutAlertBox();
            }, child:Text("Logout"))
          ],
        ),
      )
    );
  }

  void changePasswordSheet(){
    var pass;
    Get.bottomSheet(
        isScrollControlled: true,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
          ),
          height: 280,
          // color:Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                  color: Colors.grey.shade200
                ),
                  width:MediaQuery.of(context).size.width,
            alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.key_off,size: 60),
                  )),
              SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: Text("Change password",style: TextStyle(
                 color: Colors.black,
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),),
             ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black)
                ),
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      pass=val;
                    });
                  },
                  obscureText: true,
                  obscuringCharacter: "#",
                  decoration: InputDecoration(
                    hintText: "Your Password",
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.back();
                chnagePassFn(pass.toString());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2
                  )
                ),
                child: Text(""
                    "Change password"),
              ),
            ),
              SizedBox(height: 20,),
            ],
          ),
        )
    );
  }

  void chnagePassFn(String pass)async{
    debugPrint(pass.toString());
    debugPrint("pass.toString()");
    if(pass.isNotEmpty){
      Get.dialog(Center(child: CircularProgressIndicator()));
      var response=await ApiClient().changePassWord(pass);
      if(response!=null){
        // Get.back();
        Get.back();
        Fluttertoast.showToast(msg: response.toString());
      }
      debugPrint(response.toString());
    }else{
      Fluttertoast.showToast(msg: "Enter a valid password");
    }

    debugPrint("response.toString()12121212121212==========1222300000000000");
  }
}
