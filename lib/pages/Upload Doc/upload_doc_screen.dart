import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onit/component/text_form_field.dart';
import 'package:onit/utilities/app_nav.dart';
import 'package:onit/utilities/app_routes.dart';
import 'package:shimmer/shimmer.dart';

import '../../component/shimmer.dart';
import '../../data_layer/repository/homePageRepository.dart';
import '../../model/get_doc_type_model.dart';

class UploadDocScreen extends ConsumerStatefulWidget {
  const UploadDocScreen({super.key});



  @override
  ConsumerState<UploadDocScreen> createState() => _UploadDocScreenState();
}

class _UploadDocScreenState extends ConsumerState<UploadDocScreen> {
  final _alternateNumber = TextEditingController();
  GetDocTypeModel? get_doc_type_data_model;

  List<DocType> docTypeData = [];

  getDocumentType() async {

    var userDocTypeResponse = await HomeRepository().getDocType();
    if (userDocTypeResponse != null) {
      setState(() {
        get_doc_type_data_model = userDocTypeResponse;
        if (get_doc_type_data_model?.status == 1) {
          docTypeData = get_doc_type_data_model?.docType ?? [];
        } else {
          Fluttertoast.showToast(msg: get_doc_type_data_model!.message);
        }

      });
    } else {
      setState(() {

      });
    }
  }



  @override
  void initState() {
    getDocumentType();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Text(
              "Upload Qualification Certificates",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () async {
                AppNav.toNamed(AppRoutes.uploadDocScreen);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: const Text(
                  "Upload",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            get_doc_type_data_model!=null?  docTypeData.isNotEmpty? ListView.builder(
              itemCount: docTypeData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var doctDAtaList=docTypeData[index];
                return  Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Material(
                    elevation: 5,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${doctDAtaList.title}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red),
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue),
                              child: Text(
                                "View",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )


                :Container(
              child: Center(heightFactor: 10,child:Text("No data found!!")),
            ):const ShimmerWidget()
          ],
        ),
      ),
    );
  }
}
