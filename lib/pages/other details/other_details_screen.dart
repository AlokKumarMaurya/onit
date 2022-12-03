import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../component/shimmer.dart';
import '../../component/text_form_field.dart';
import '../../data_layer/repository/homePageRepository.dart';
import '../../model/get_user_other_data.dart';
import '../../utilities/app_nav.dart';
import '../../utilities/app_routes.dart';

class OtherDetailsScreen extends ConsumerStatefulWidget {
  const OtherDetailsScreen({super.key});



  @override
  ConsumerState<OtherDetailsScreen> createState() => _OtherDetailsScreenState();
}

class _OtherDetailsScreenState extends ConsumerState<OtherDetailsScreen> {
  final _alterateContactNumber = TextEditingController();
  final _gender = TextEditingController();
  final _nationality = TextEditingController();
  final _qualification = TextEditingController();
  final _textFieldText = TextEditingController();
  GetUserOtherModel? get_user_other_data_model;

  List<UserOtherDatum> userOtherData = [];

  getUserOtherData() async {
    var userOtherDataResponse = await HomeRepository().getUserOtherDetails();
    if (userOtherDataResponse != null) {
      setState(() {
        get_user_other_data_model = userOtherDataResponse;
        if (get_user_other_data_model?.status == 1) {
          userOtherData = get_user_other_data_model?.userOtherData ?? [];
        } else {
          Fluttertoast.showToast(msg: get_user_other_data_model!.message);
        }
      });
    } else {}
  }
  @override
  void initState() {
    getUserOtherData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Enter Your Other Details Properly",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            get_user_other_data_model != null
                ? userOtherData.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: userOtherData.length,
                        itemBuilder: (context, index) {
                          var otherData = userOtherData[index];
                          return Card(
                              elevation: 10,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "${otherData.title}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.grey)),
                                        child: Text("${otherData.value}"),
                                      )
                                    ],
                                  ) /*Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alternate Number"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(cotroller: _alterateContactNumber,hintText: "Alternate Number",
                      prefixIcon:Container()
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const  Text("Gender"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(cotroller: _gender,hintText: "Gender",
                      prefixIcon:Container()
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Nationality"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(cotroller: _nationality,hintText: "Nationality",
                      prefixIcon:Container()
                    ),
                    const SizedBox(
                      height: 10,
                    ),






                    const Text("Qualification"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(cotroller: _qualification,hintText: "Qualification",
                      prefixIcon:Container()
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Text Field Text"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(cotroller: _textFieldText,hintText: "Text Field Text",
                      prefixIcon: Container()
                    ),









                  ],
                ),*/
                                  ));
                        },
                      )
                    : const Center(
                        heightFactor: 10, child: Text("No Data Found"))
                : const ShimmerWidget(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),

                        //////// HERE
                      ),
                      onPressed: () {
                        AppNav.toNamed(AppRoutes.homepage);
                      },
                      child: const Text("Update")),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
