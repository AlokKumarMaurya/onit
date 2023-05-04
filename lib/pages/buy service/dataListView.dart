import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/buyServiceListController.dart';

class BuyServiceListView extends StatelessWidget {
  BuyServiceListView({Key? key}) : super(key: key);

  final BuyServiceListController buyServiceListController =
      Get.put(BuyServiceListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => buyServiceListController.dataList.value != null
        ? buyServiceListController.dataList.value!.data.isNotEmpty
            ? ListView.builder(
                itemCount: buyServiceListController.dataList.value!.data.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    print("working");
                    buyServiceListController.currentCatId.value =
                        buyServiceListController.dataList.value!.data[index].id;
                    buyServiceListController.shouldShowDetailView.value = true;
                    print("testing");
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(2, 2),
                              blurRadius: 12,
                              color: Colors.grey.shade300)
                        ]),
                    child: ListTile(
                      title: Text(buyServiceListController
                          .dataList.value!.data[index].title),
                    ),
                  ),
                ),
              )
            : const Center(
                child: Text("No data found"),
              )
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }
}
