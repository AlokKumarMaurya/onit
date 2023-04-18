import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../component/shimmer.dart';
import '../../data_layer/repository/homePageRepository.dart';
import '../../model/service_applied_model.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen( {super.key});



  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {


  ServiceAppliedModel? applied_service_model;
  List<ServiceAppliedList> applied_service_list = [];

  appliedServices() async {

    var appliedServiceResponse = await HomeRepository().servicesApplied();
    if (appliedServiceResponse != null) {
      setState(() {
        applied_service_model = appliedServiceResponse;
        print("appliedService" +
            applied_service_model!.serviceAppliedList.toString());
        if (applied_service_model?.status == 1) {
          applied_service_list =
              applied_service_model?.serviceAppliedList ?? [];
        } else {
          Fluttertoast.showToast(msg: applied_service_model!.message);
        }

      });
    } else {
      setState(() {

      });
    }
  }

  @override
  void initState() {
    appliedServices();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              "Services You Asked",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            applied_service_model!=null?  applied_service_list.isNotEmpty?
            ListView.builder(
                        itemCount: applied_service_list.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var appliedList= applied_service_list[index];
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
                                      appliedList.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Pay Status: ",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          appliedList.paymentStatus,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    const Icon(
                                      Icons.verified_outlined,
                                      color: Colors.green,
                                      size: 12,
                                    ),
                                    /* Text("Pay Mehtod: ",
                         style: TextStyle(fontSize: 12, color: Colors.grey)),*/
                                    Text(" ${appliedList.paymentMethod}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹ ${appliedList.amount}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      "${appliedList.remark}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ):Container(
              child: Center(heightFactor:10,child:Text("No data found!!")),
            ) :ShimmerWidget()


          ],
        ),
      ),
    );
  }
}
