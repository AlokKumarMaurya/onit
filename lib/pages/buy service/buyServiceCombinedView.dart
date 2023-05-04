import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/buyServiceListController.dart';
import 'buy_service_screen.dart';
import 'dataListView.dart';

class BuyServiceCombineView extends StatelessWidget {
  BuyServiceCombineView({Key? key}) : super(key: key);

  final BuyServiceListController buyServiceListController =
      Get.put(BuyServiceListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Onit"),
        centerTitle: true,
      ),
      body: Obx(() => buyServiceListController.shouldShowDetailView.value
          ? BuyService(
              catID: buyServiceListController.currentCatId.value.toString(),
            )
          : BuyServiceListView()),
    );
  }
}
