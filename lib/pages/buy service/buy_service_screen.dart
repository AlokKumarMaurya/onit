import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../component/shimmer.dart';
import '../../data_layer/repository/homePageRepository.dart';
import '../../model/service_model.dart';
import '../../utilities/app_prefereces.dart';

class BuyService extends ConsumerStatefulWidget {
  const BuyService( {super.key});

  @override
  ConsumerState<BuyService> createState() => _BuyServiceState();
}

class _BuyServiceState extends ConsumerState<BuyService> {

  ServiceModel? service_model;
  List<ServiceData> serviceData = [];

  getservices() async {

    var response = await HomeRepository().getService();
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
      setState(() {

      });
    }
  }




  Razorpay _razorpay = Razorpay();
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    getservices();

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Something get wrong with payment");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {

  }
  razorPayPayment({required String description, required String name, required int amount}){
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    String razorpayKey=AppPreference().razorpayKey;

    if(razorpayKey!=""){
      var options = {
        'key': razorpayKey,
        'amount': amount*100,
        'name': name,
        'description':description,
        'prefill': {
          'contact': '',
          'email': ''
        }
      };
      _razorpay.open(options);
    }else{
      Fluttertoast.showToast(msg: "Razor Pay Key is not correct!");
    }

  }



  @override
  void initState() {
    getservices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Text(
              "Buy New Service",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            service_model!=null? serviceData.isNotEmpty? ListView.builder(itemCount: serviceData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var serviceList=serviceData[index];
                return    Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                  child: Material(
                    elevation: 5,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            serviceList.title,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),

                        ],
                      ),
                      subtitle: Text(" ${serviceList.content}",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹ ${serviceList.price}",
                            style:
                            const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () async {
                              razorPayPayment(amount:int.parse(serviceList.price) ,description:serviceList.content,name: serviceList.title );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue),
                              child: const Text(
                                "Pay Now",
                                style: TextStyle(color: Colors.white,fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },)


                :const Center(heightFactor:10,child:Text("No data found!!"))
                :ShimmerWidget()],
        ),
      ),
    );
  }
}
