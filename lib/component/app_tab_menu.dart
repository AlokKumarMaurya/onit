import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../api config/api_client.dart';
import '../data_layer/repository/homePageRepository.dart';
import '../model/bannerModal.dart';
import '../model/get_config_model.dart';
import '../pages/Upload Doc/upload_doc_screen.dart';
import '../pages/buy service/buyServiceCombinedView.dart';
import '../pages/orders/orders_Screen.dart';
import '../pages/other details/other_details_screen.dart';
import '../utilities/app_nav.dart';
import '../utilities/app_prefereces.dart';
import '../utilities/app_routes.dart';

class AppTabMenu extends StatefulWidget {
  final List<String> menuItemsList;
  Function(int index) onItemClick;
  final int selectedIndex;
  final double fontSize;
  final EdgeInsets? margin, padding;

  AppTabMenu(
      {super.key, required this.menuItemsList,
      required this.onItemClick,
      required this.selectedIndex,
      this.fontSize = 16,
      this.margin,
      this.padding});

  @override
  State<AppTabMenu> createState() => _AppTabMenuState();
}

class _AppTabMenuState extends State<AppTabMenu> {
  final List<Color> colorList = [
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.indigoAccent,
    Colors.red
  ];
  final List<Color> backgroundColorList = [
    const Color(0xffffb520),
    const Color(0xff3ea1be),
    const Color(0xffC6BE2F),
    const Color(0xffd34269)
  ];
  RxList<BannerModalDatum> bannerModalDatum =
      List<BannerModalDatum>.empty(growable: true).obs;

  @override
  void initState() {
    getConfigs();
    getBannerList();
    // TODO: implement initState
    super.initState();
  }

  List<ConfigList> configDataList = [];
  GetConfigModel? get_config_model;
  getConfigs() async {
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
       // services_loader = false;
      });
    } else {
      setState(() {
        //services_loader = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        openExitBottomSheet();
        return false;
      },
      child: Scaffold(backgroundColor: const Color(0xff073765),
        appBar: AppBar(backgroundColor: const Color(0xffFF9400),elevation: 0,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => bannerModalDatum.length > 0
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CarouselSlider.builder(

                        itemCount: bannerModalDatum.length,
                        itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) =>
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15) ,    color: const Color(0xff073765),),
                          width: Get.width,

                          child: Image.network(
                           "http://test.devarshidevaldhaam.com/upload/slider/${bannerModalDatum[index].photo}",
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              "assets/noImage.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        options: CarouselOptions(autoPlay: true, height: 150,
                        ),
                      ),
                    )
                  : const SizedBox()),
              BuyServiceCombineView(),
              GridView.builder(padding: const EdgeInsets.symmetric(horizontal: 5),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.menuItemsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
childAspectRatio: 0.85
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    if (index == 0) {
                      Get.to(() => const OrderScreen());
                    } else if (index == 1) {
                      Get.to(() => const OtherDetailsScreen());
                    } else if (index == 2) {
                      Get.to(() => const UploadDocScreen());
                    }
                    widget.onItemClick(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 3),
                  //  padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(

                        color:backgroundColorList[index],
                     ),
                    child: Container(
                      // color: colorList[index],
                      decoration: const BoxDecoration(),
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
                                        ? Icons.person
                                        : Icons.upload_file_outlined,
                            size: 40,
                            color:Colors.white,
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            widget.menuItemsList[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openDialog() {
    Get.bottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        Container(
          decoration: const BoxDecoration(
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
                  child: const Text("Change Password")),
              TextButton(
                  onPressed: () {
                    Get.back();
                    logoutAlertBox();
                  },
                  child: const Text("Logout"))
            ],
          ),
        ));
  }

  void changePasswordSheet() {
    var pass;
    Get.bottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          height: 280,
          // color:Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                      color: Colors.grey.shade200),
                  width: MediaQuery.of(Get.context!).size.width,
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(Icons.key_off, size: 60),
                  )),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Change password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(Get.context!).size.width,
                height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  decoration: const InputDecoration(
                      hintText: "Your Password", border: InputBorder.none),
                ),
              ),
              const SizedBox(
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                  child: const Text(""
                      "Change password"),
                ),
              ),
              const SizedBox(
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
      Get.dialog(const Center(child: CircularProgressIndicator()));
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
        titleStyle: const TextStyle(
            fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500),
        middleText: "Are you sure that you want to logout from Onit ",
        textCancel: "Cancel",
        textConfirm: "Logout",
        middleTextStyle: const TextStyle(
            fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w400),
        cancel: InkWell(
          onTap: () => Navigator.pop(Get.context!),
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: MediaQuery.of(Get.context!).size.width / 3.5,
            child: const Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
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
            width: MediaQuery.of(Get.context!).size.width / 3.5,
            child: const Text(
              "Logout",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
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
          const Text(
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
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
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
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
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

  void getBannerList() async {
    print("213123442423123");
    try {
      BannerModal modal = await ApiClient().getBanner();
      bannerModalDatum.value = modal.data;
    } catch (e) {
      print(e.toString());
      bannerModalDatum.value = [];
    }
  }
}
