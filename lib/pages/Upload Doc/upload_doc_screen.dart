import 'dart:convert';
import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/api%20config/onit_url.dart';
import 'package:onit/component/text_form_field.dart';
import 'package:onit/utilities/app_nav.dart';
import 'package:onit/utilities/app_routes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../../api config/api_client.dart';
import '../../component/shimmer.dart';
import '../../data_layer/repository/homePageRepository.dart';
import '../../model/all_uploaded_doc_modal.dart';
import '../../model/get_doc_type_model.dart';
import '../../utilities/app_prefereces.dart';

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
RxList<Datum> uploadedDocList=RxList<Datum>.empty(growable: true);
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
    getAllUploadedDoc();
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





            Obx(()=>uploadedDocList.value!=null?  uploadedDocList.value.isNotEmpty?
            ListView.builder(
              itemCount: uploadedDocList.value.length,
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
                            "${uploadedDocList.value[index].title}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Text("Uploaded on : ${uploadedDocList.value[index].createdAt.toString().padLeft(10)}"),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // debugPrint(doctDAtaList.)
                                },
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
                            onTap: () async {
Get.to(ViewDocumentPdf(url:uploadedDocList.value[index].fileName));
                            },
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
            ):const ShimmerWidget()),
















            
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
  crossAxisAlignment: CrossAxisAlignment.center,
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
              List<String> fExtension = ["pdf", "doc", "docx","png","jpg","jpeg"];

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
                hint: Text("Select value",style: TextStyle(
                    color: Colors.black
                ),),
                items: docTypeData.map((e){
                  return DropdownMenuItem(
                      value: e.title,
                      child: Text(e.title)) ;
                }).toList(), onChanged:(val){
//                   selectedDocType=Rxn();
//               selectedDocType.value=val;
                  debugPrint(val.toString());
                  selectedDocType.value=val;

//                   // setState((){
//                   //   selectedDocType.value=val;
//                   // });
// debugPrint(selectedDocType.value);
                },
              value: selectedDocType.value,
            ),

        )));
  }


  void getAllUploadedDoc()async{
    var temp=await AppPreference().profileHash;
    var res=await http.post(Uri.parse(OnitUrl.getAllUserFile),body: {
      "profile_hash": temp
    });

    debugPrint(res.statusCode.toString());
    debugPrint(temp.toString());
    debugPrint(res.body.toString());
    if(res.statusCode==200){
      UploadedDocumentModal modal=UploadedDocumentModal.fromJson(jsonDecode(res.body));
      uploadedDocList.value=modal.data;
    }

  }
}




class ViewDocumentPdf extends StatefulWidget {
   ViewDocumentPdf({Key? key,required this.url}) : super(key: key);
String url;

  @override
  State<ViewDocumentPdf> createState() => _ViewDocumentPdfState();
}

class _ViewDocumentPdfState extends State<ViewDocumentPdf> {
  PDFDocument? document;
  @override
  void initState() {

    loadDoc();
    // TODO: implement initState
    super.initState();
  }

  loadDoc()async{
    var aa=await PDFDocument.fromURL(widget.url);
    setState(()  { document =aa; });

  }



  @override
  Widget build(BuildContext context) {
    return PDFViewer(
      document: document!,
      zoomSteps: 1,
      //uncomment below line to preload all pages
      // lazyLoad: false,
      // uncomment below line to scroll vertically
      scrollDirection: Axis.vertical,

      //uncomment below code to replace bottom navigation with your own
      /* navigationBuilder:
                          (context, page, totalPages, jumpToPage, animateToPage) {
                        return ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.first_page),
                              onPressed: () {
                                jumpToPage()(page: 0);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                animateToPage(page: page - 2);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                animateToPage(page: page);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.last_page),
                              onPressed: () {
                                jumpToPage(page: totalPages - 1);
                              },
                            ),
                          ],
                        );
                      }, */
    );
  }
}
