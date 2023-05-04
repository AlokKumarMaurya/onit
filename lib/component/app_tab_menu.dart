import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../api config/api_client.dart';
import '../pages/Upload Doc/upload_doc_screen.dart';
import '../pages/buy service/buyServiceCombinedView.dart';
import '../pages/orders/orders_Screen.dart';
import '../pages/other details/other_details_screen.dart';
import '../utilities/app_nav.dart';
import '../utilities/app_prefereces.dart';
import '../utilities/app_routes.dart';

class AppTabMenu extends StatelessWidget {
  final List<String> menuItemsList;
  Function(int index) onItemClick;
  final int selectedIndex;
  final double fontSize;
  final EdgeInsets? margin, padding;

  AppTabMenu(
      {required this.menuItemsList,
      required this.onItemClick,
      required this.selectedIndex,
      this.fontSize = 16,
      this.margin,
      this.padding});

  final List<Color> colorList = [
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.indigoAccent,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        openExitBottomSheet();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Onit"),
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
        body: Container(
          // height: 50,
          // width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(color: AppColors.borderShade3)
          ),
          margin: margin ??
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // padding:padding?? EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: menuItemsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (index == 0) {
                  Get.to(() => OrderScreen());
                } else if (index == 1) {
                  Get.to(() => BuyServiceCombineView());
                } else if (index == 2) {
                  Get.to(() => OtherDetailsScreen());
                } else if (index == 3) {
                  Get.to(() => UploadDocScreen());
                }
                onItemClick(index);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        // offset: const Offset(2, 2),
                        spreadRadius: 5,
                        blurRadius: 12,
                        color: /*colorList[index]
                              .withOpacity(0.3) */
                            Colors.grey.shade200,
                      )
                    ]),
                child: Container(
                  // color: colorList[index],
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0
                            ? Icons.miscellaneous_services
                            : index == 1
                                ? Icons.note_alt_rounded
                                : index == 3
                                    ? Icons.upload_file_sharp
                                    : Icons.person,
                        size: 40,
                        color: colorList[index],
                      ),
                      Text(
                        menuItemsList[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ) /*Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HorizontalScrollView(
                  children: List.generate(menuItemsList.length, (index) {
                    var menuItem = menuItemsList[index];
                    return GestureDetector(
                      onTap:() => onItemClick(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: selectedIndex == index
                                      ? Colors.blue
                                      : Colors.white,
                                  width: 5)),
                        ),
                        padding: const EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
                        child: Text(
                          menuItem,
                         //
                          style: TextStyle(

                              fontSize: fontSize,color: selectedIndex==index?Colors.blue:Colors.black
                          ),


                        ),
                      ),
                    );
                  }),
                ),
              ])*/
          ,
        ),
      ),
    );
  }

  void openDialog() {
    Get.bottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          height: 100,
          // color:Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Get.back();
                    changePasswordSheet();
                  },
                  child: Text("Change Password")),
              TextButton(
                  onPressed: () {
                    Get.back();
                    logoutAlertBox();
                  },
                  child: Text("Logout"))
            ],
          ),
        ));
  }

  void changePasswordSheet() {
    var pass;
    Get.bottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          height: 280,
          // color:Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                      color: Colors.grey.shade200),
                  width: MediaQuery.of(Get.context!).size.width,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.key_off, size: 60),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Change password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(Get.context!).size.width,
                height: 40,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  onChanged: (val) {
                    //setState(() {
                    pass = val;
                    // });
                  },
                  obscureText: true,
                  obscuringCharacter: "#",
                  decoration: InputDecoration(
                      hintText: "Your Password", border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  chnagePassFn(pass.toString());
                },
                child: Container(
                  width: MediaQuery.of(Get.context!).size.width,
                  height: 35,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Text(""
                      "Change password"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  void chnagePassFn(String pass) async {
    debugPrint(pass.toString());
    debugPrint("pass.toString()");
    if (pass.isNotEmpty) {
      Get.dialog(Center(child: CircularProgressIndicator()));
      var response = await ApiClient().changePassWord(pass);
      if (response != null) {
        // Get.back();
        Get.back();
        Fluttertoast.showToast(msg: response.toString());
      }
      debugPrint(response.toString());
    } else {
      Fluttertoast.showToast(msg: "Enter a valid password");
    }

    debugPrint("response.toString()12121212121212==========1222300000000000");
  }

  void logoutAlertBox() {
    Get.defaultDialog(
        title: "Logout",
        titleStyle: TextStyle(
            fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500),
        middleText: "Are you sure that you want to logout from Onit ",
        textCancel: "Cancel",
        textConfirm: "Logout",
        middleTextStyle: TextStyle(
            fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400),
        cancel: InkWell(
          onTap: () => Navigator.pop(Get.context!),
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            width: MediaQuery.of(Get.context!).size.width / 3.5,
          ),
        ),
        confirm: InkWell(
          onTap: () {
            AppNav.offAllToNamed(AppRoutes.loginPage);
            AppPreference().saveLogin(false);
            AppPreference().saveRazorPayKey("");

            AppPreference().saveProfileHash("");
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            width: MediaQuery.of(Get.context!).size.width / 3.5,
          ),
        ),
        onCancel: () {
          print("cancledd clicked");
          Navigator.pop(Get.context!);
        },
        onConfirm: () {
          print("confirm clicked");
          AppNav.offAllToNamed(AppRoutes.loginPage);
          AppPreference().saveLogin(false);
          AppPreference().saveRazorPayKey("");

          AppPreference().saveProfileHash("");
        });
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

  void openExitBottomSheet() {
    Get.bottomSheet(Container(
      height: 150,
      width: Get.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            "Are you sure that you want to exit",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pop(Get.context!),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => exit(0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Exit",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
