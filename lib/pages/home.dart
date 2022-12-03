import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onit/data_layer/repository/homePageRepository.dart';
import 'package:onit/pages/Upload%20Doc/upload_doc_screen.dart';
import 'package:onit/pages/orders/orders_Screen.dart';
import 'package:onit/pages/other%20details/other_details_screen.dart';
import 'package:onit/pages/update%20profile/update_profile_screen.dart';
import 'package:onit/utilities/app_nav.dart';
import 'package:onit/utilities/app_routes.dart';


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
                  AppNav.toNamed(AppRoutes.loginPage);
                  AppPreference().saveLogin(false);
                  AppPreference().saveRazorPayKey("");
                  
                  AppPreference().saveProfileHash("");
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
                  "Your Orders",
                  "Buy Service",
                  "Upload Doc",
                  "Update Profile",
                  "Other Details",
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
      return const UploadDocScreen();
    } else if (selectedIndex == 3) {
      return const UpdateProfileScreen();
    } else if (selectedIndex == 4) {
      return const OtherDetailsScreen();
    } else {
      return const OrderScreen();
    }
  }
}
