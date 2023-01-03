import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/component/text_form_field.dart';
import 'package:onit/utilities/app_nav.dart';
import 'package:onit/utilities/app_routes.dart';
import 'package:shimmer/shimmer.dart';

import '../../api config/api_client.dart';
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
Rxn selectedDocType=Rxn();
  List<DocType> docTypeData = [];
  File? file;
  RxString filesname="".obs;

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
            SizedBox(height: 20,),
            const Text(
              "Upload Qualification Certificates",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                uploadDocDialod(context);
                //AppNav.toNamed(AppRoutes.uploadDocScreen);
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
            // get_doc_type_data_model!=null?  docTypeData.isNotEmpty?
            // ListView.builder(
            //   itemCount: docTypeData.length,
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) {
            //     var doctDAtaList=docTypeData[index];
            //     return  Padding(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            //       child: Material(
            //         elevation: 5,
            //         child: ListTile(
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10)),
            //           title: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "${doctDAtaList.title}",
            //                 style: TextStyle(fontWeight: FontWeight.w600),
            //               ),
            //             ],
            //           ),
            //           subtitle: Row(
            //             children: [
            //               GestureDetector(
            //                 onTap: () async {
            //                   // debugPrint(doctDAtaList.)
            //                 },
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 10, vertical: 5),
            //                   margin: EdgeInsets.symmetric(vertical: 5),
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(5),
            //                       color: Colors.red),
            //                   child: Text(
            //                     "Delete",
            //                     style: TextStyle(
            //                         color: Colors.white, fontSize: 12),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           trailing: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(
            //                 height: 5,
            //               ),
            //               GestureDetector(
            //                 onTap: () async {},
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 10, vertical: 5),
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(5),
            //                       color: Colors.blue),
            //                   child: Text(
            //                     "View",
            //                     style: TextStyle(
            //                         color: Colors.white, fontSize: 12),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 5,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // )
            //
            //
            //     :Container(
            //   child: Center(heightFactor: 10,child:Text("No data found!!")),
            // ):const ShimmerWidget()
          ],
        ),
      ),
    );
  }

  void uploadDocDialod(BuildContext context) async{
   await Get.dialog(
         Card(color: Colors.transparent,
      child: Center(
          child: Container(
            color: Colors.white,
            height: 300,
            width: 300,
            alignment: Alignment.center,
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
      SizedBox(height: 10,),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("Upload Document",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),

              IconButton(onPressed: (){
                Get.back();
                file=null;
                filesname.value="";
                selectedDocType=Rxn();
              }, icon: Icon(Icons.backspace_outlined)),

            ],
        ),
      ),
      SizedBox(height: 5,),
      Divider(
        thickness: 1,
          height: 1,
        color: Colors.black,
      ),
      SizedBox(height: 10,),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        child: Text("Document type",style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),),
      ),
      SizedBox(height: 4,),
      customDropDown(),
      SizedBox(height: 10,),
Container(
  height: 50,
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.black
    )
  ),
  margin: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
        InkWell(
            onTap: ()async {
              List<String> fExtension = ["pdf", "doc", "docx"];

              FilePickerResult? result =
              await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: fExtension,
              );
              if (result != null) {
                String p = result.files.single.path!;
                // print(("checking path for file picker");
                // print((result.files.single.path!);
                file = File(p);
                setState(() {
                  filesname.value = file!.path.split('/').last;
                });
              } else {
                // User canceled the picker
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: Colors.grey,
              child: Text(
                "Choose file",style: TextStyle(
                fontSize: 16
              ),
              ),
            ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/2,
          child: Obx(()=>Text(filesname.value,style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16
          )),),
        )
    ],

  ),
),
      SizedBox(height: 20,),
      Padding(
        padding:  EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){
                ApiClient().uploadDocNew(file);
              }, child:Text("Upload ")),
              Text("")
            ],
        ),
      )

  ],
),
          ),
        ),
    )
    );
  }

  customDropDown() {
    return  Obx(() =>  Container(
        padding:EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black)
        ),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
                isExpanded: true,
                // style: TextStyle(
                //   overflow: TextOverflow.ellipsis,
                //   color: Colors.black,
                //   fontSize: 15
                // ),
                hint: Text("Select value",style: TextStyle(
                    color: Colors.black
                ),),
                items: docTypeData.map((e){
                  return DropdownMenuItem(
                      value: e.title,
                      child: Text(e.title)) ;
                }).toList(), onChanged:(val){
//                   selectedDocType=Rxn();
//               selectedDocType.value=val.toString();
                  debugPrint(val.toString());
//                   // setState((){
//                   //   selectedDocType.value=val;
//                   // });
// debugPrint(selectedDocType.value);
                },
              value: selectedDocType.value,
            ),

        )));
  }
}
