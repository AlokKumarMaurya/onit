import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:onit/api%20config/onit_url.dart';
import 'package:onit/controllers/buyServiceListController.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../component/shimmer.dart';
import '../../data_layer/repository/homePageRepository.dart';
import '../../model/service_model.dart';
import '../../utilities/app_prefereces.dart';

class BuyService extends ConsumerStatefulWidget {
  final String catID;
  const BuyService({super.key, required this.catID});

  @override
  ConsumerState<BuyService> createState() => _BuyServiceState();
}

class _BuyServiceState extends ConsumerState<BuyService> {
  ServiceModel? service_model;
  List<ServiceData> serviceData = [];
  int temp_amount = 0;
  String? profileHash;
  String? serviceId;

  getservices() async {
    var response = await HomeRepository().getService(catId: widget.catID);
    if (response != null) {
      setState(() {
        service_model = response;
        if (service_model?.status == 1) {
          serviceData = service_model?.data ?? [];
          _razorpay.clear();
        } else {
          Fluttertoast.showToast(msg: service_model!.message);
        }
      });
    } else {
      setState(() {});
    }
  }

  applyServiceApi(String orderId, String paymentId) async {
    var response = await http.post(Uri.parse(OnitUrl.applyService), body: {
      "razorpay_order_id": orderId.toString(),
      "profile_hash": profileHash!,
      "price": temp_amount.toString(),
      " razorpay_payment_id": paymentId.toString(),
      "service_id": serviceId.toString(),
    });
    debugPrint("39849794739473749379479493");
    debugPrint(response.body.toString());
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      var tem = jsonDecode(response.body);
      Fluttertoast.showToast(msg: tem["message"]);
    }
  }

  final Razorpay _razorpay = Razorpay();
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("payment successful");
    // debugPrint(response);
    applyServiceApi(response.orderId.toString(), response.paymentId.toString());
    getservices();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Something get wrong with payment");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  razorPayPayment(
      {required String description,
      required String name,
      required int amount}) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    String razorpayKey = AppPreference().razorpayKey;

    if (razorpayKey != "") {
      var options = {
        'key': razorpayKey,
        'amount': amount * 100,
        'name': name,
        'description': description,
        'prefill': {'contact': '', 'email': ''}
      };
      _razorpay.open(options);
    } else {
      Fluttertoast.showToast(msg: "Razor Pay Key is not correct!");
    }
  }

  getProfileHash() async {
    setState(() {
      profileHash = AppPreference().profileHash;
    });
  }

  @override
  void initState() {
    getProfileHash();
    getservices();
    super.initState();
  }

  BuyServiceListController buyServiceListController =
      Get.put(BuyServiceListController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        buyServiceListController.shouldShowDetailView.value = false;
        return false;
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Text(
                "Forms",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              service_model != null
                  ? serviceData.isNotEmpty
                      ? ListView.builder(
                          itemCount: serviceData.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var serviceList = serviceData[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: Material(
                                elevation: 5,
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        serviceList.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(" ${serviceList.content}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Created at: ${DateFormat.yMMMMd().format(DateTime.parse(serviceList.createdAt.toString()))}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Updated at: ${DateFormat.yMMMMd().format(DateTime.parse(serviceList.updatedAt.toString()))}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹ ${serviceList.price}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (serviceList.status == "0" ||
                                              serviceList.status == 0) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "You already purchased this serivce");
                                          } else {
                                            setState(() {
                                              serviceId = serviceList.sId;
                                              temp_amount =
                                                  int.parse(serviceList.price);
                                            });
                                            razorPayPayment(
                                                amount: int.parse(
                                                    serviceList.price),
                                                description:
                                                    serviceList.content,
                                                name: serviceList.title);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.blue),
                                          child: const Text(
                                            "Pay Now",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          heightFactor: 10, child: Text("No data found!!"))
                  : ShimmerWidget()
            ],
          ),
        ),
      ),
    );
  }
}
