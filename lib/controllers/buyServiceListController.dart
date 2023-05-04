import 'package:get/get.dart';
import 'package:onit/api%20config/onit_url.dart';

import '../model/allBuyServiceListModal.dart';

class BuyServiceListController extends GetxController {
  Rxn<AllBuyServiceModal> dataList = Rxn();
  RxBool shouldShowDetailView = false.obs;
  RxString currentCatId = "0".obs;

  void getData() async {
    var res =
        await GetConnect().get(OnitUrl.getAllBuyServiceList).then((value) {
      if (value.body != null) {
        try {
          AllBuyServiceModal modal = allBuyServiceModalFromJson(value.body);
          dataList.value = modal;
        } catch (e) {
          dataList.value = AllBuyServiceModal(status: 0, message: "", data: []);
        }
      }
    });
  }

  @override
  void onInit() {
    getData();
    // TODO: implement onInit
    super.onInit();
  }
}
