import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onit/api%20config/onit_url.dart';

import '../../controllers/buyServiceListController.dart';
import 'buy_service_screen.dart';

class BuyServiceListView extends StatelessWidget {
  BuyServiceListView({Key? key}) : super(key: key);

  final BuyServiceListController buyServiceListController =
      Get.put(BuyServiceListController());
  final List<Color> backgroundColorList = [
    Color(0xff4F6685),
    Color(0xfff79301),
    Color(0xffe04445),
    Colors.red
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => buyServiceListController.dataList.value != null
        ? buyServiceListController.dataList.value!.data.isNotEmpty
            ? GridView.builder(padding: const EdgeInsets.symmetric(horizontal: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                    childAspectRatio: 0.85
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
                        margin: const EdgeInsets.only(
                          top: 5, left: 3,right: 3),
                        // color: colorList[index],
                        decoration: BoxDecoration(
                          color: backgroundColorList[index],
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
                            SizedBox(height: 10,),
                            Text(
                              buyServiceListController
                                  .dataList.value!.data[index].title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
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
