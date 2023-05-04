import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onit/api%20config/onit_url.dart';

import '../../controllers/buyServiceListController.dart';
import 'buy_service_screen.dart';

class BuyServiceListView extends StatelessWidget {
  BuyServiceListView({Key? key}) : super(key: key);

  final BuyServiceListController buyServiceListController =
      Get.put(BuyServiceListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => buyServiceListController.dataList.value != null
        ? buyServiceListController.dataList.value!.data.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1.2,
                ),
                itemCount: buyServiceListController.dataList.value!.data.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics:
                    const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  print(OnitUrl.imagePath +
                      buyServiceListController
                          .dataList.value!.data[index].image +
                      "     hjghhjgggg");
                  return InkWell(
                      onTap: () {
                        Get.to(() => BuyService(
                              catID: buyServiceListController.currentCatId.value
                                  .toString(),
                            ));
                        print("working");
                        /*buyServiceListController.currentCatId.value =
                          buyServiceListController
                              .dataList.value!.data[index].id;
                      buyServiceListController.shouldShowDetailView.value =
                          true;
                      print("testing");*/
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
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
                              Image.network(
                                OnitUrl.imagePath +
                                    buyServiceListController
                                        .dataList.value!.data[index].image,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  "assets/noImage.png",
                                  scale: 1.5,
                                ),
                              ),
                              Text(
                                buyServiceListController
                                    .dataList.value!.data[index].title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              )
            : const Center(
                child: Text("No data found"),
              )
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }
}
