import 'dart:convert';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onit/api%20config/onit_url.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Rxn selectedDocType = Rxn();
  RxInt selectedFileType = 1.obs;
  RxList testList = List.empty(growable: true).obs;
  List<DocType> docTypeData = [];
  File? file;
  RxString filesname = "".obs;
  RxList<Datum> uploadedDocList = RxList<Datum>.empty(growable: true);
  var temp;
  getDocumentType() async {
    var userDocTypeResponse = await HomeRepository().getDocType();
    if (userDocTypeResponse != null) {
      setState(() {
        get_doc_type_data_model = userDocTypeResponse;
        if (get_doc_type_data_model?.status == 1) {
          docTypeData = get_doc_type_data_model?.docType ?? [];
          var te = docTypeData.forEach((element) {
            debugPrint(element.title);
            debugPrint(element.type);
            element.type == "0"
                ? testList.add(element.title)
                : debugPrint("not adding");
            if (element.type == 0) {
              testList.add(element.title);
            }
          });
          debugPrint(testList.toString());
        } else {
          Fluttertoast.showToast(msg: get_doc_type_data_model!.message);
        }
      });
    } else {
      setState(() {});
    }
  }

  deleteDocument() async {}

  @override
  void initState() {
    getAllUploadedDoc();
    getDocumentType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Onit"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              const Text(
                "Upload Qualification Certificates",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() => uploadedDocList.value != null
                  ? uploadedDocList.value.isNotEmpty
                      ? ListView.builder(
                          itemCount: uploadedDocList.value.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var doctDAtaList = docTypeData[index];
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
                                        "${uploadedDocList.value[index].title}",
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
                                      Text(
                                          "Uploaded on : ${uploadedDocList.value[index].createdAt.toString().padLeft(10)}"),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              // debugPrint(doctDAtaList.)
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.red),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          _launchUrl(uploadedDocList
                                              .value[index].fileName);
                                          debugPrint(uploadedDocList
                                              .value[index].fileName);
                                          // Get.to(() => ViewDocumentPdf(
                                          //     url: uploadedDocList.value[index].fileName));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue),
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
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
                      : Container(
                          child: Center(
                              heightFactor: 10, child: Text("No data found!!")),
                        )
                  : const ShimmerWidget()),
              GestureDetector(
                onTap: () async {
                  uploadDocDialod(context);
                  //AppNav.toNamed(AppRoutes.uploadDocScreen);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
      ),
    );
  }

  void uploadDocDialod(BuildContext context) async {
    await Get.dialog(Card(
      color: Colors.transparent,
      child: Center(
        child: Container(
          color: Colors.white,
          height: 300,
          width: 300,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upload Document",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                          file = null;
                          filesname.value = "";
                          selectedDocType = Rxn();
                        },
                        icon: Icon(Icons.backspace_outlined)),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
                height: 1,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Text(
                  "Document type",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              customDropDown(context),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          List<String> fExtension = [
                            "pdf",
                            "doc",
                            "docx",
                            "png",
                            "jpg",
                            "jpeg"
                          ];

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
                          child: const Text(
                            "Choose file",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Obx(
                          () => Text(filesname.value,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16)),
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          ApiClient()
                              .uploadDocNew(file, selectedFileType.value)
                              .then((value) {
                            if (value != null) {
                              debugPrint("323239828389238983299399293");
                              getAllUploadedDoc();
                              selectedFileType.value = 0;
                              selectedDocType.value = null;
                              filesname.value = "";

                              setState(() {
                                temp = null;
                              });
                            }
                          });
                        },
                        child: const Text("Upload ")),
                    const Text("")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  customDropDown(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Card(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black)),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                hint: const Text(
                  "Select type",
                  style: TextStyle(color: Colors.black),
                ),
                items: testList.toSet().map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (val) {
//                   selectedDocType=Rxn();

                  selectedDocType.value = val;
//                   debugPrint(val.toString());
                  setState(() {
                    temp = val.toString();
                    selectedDocType.value = val;
                    var tttt = docTypeData.where((element) {
                      if (element.title == selectedDocType.value) {
                        selectedFileType.value = int.parse(element.typeId);
                      }
                      return true;
                    });
                    debugPrint(selectedFileType.value.toString());
                    debugPrint(tttt.toString());
                    debugPrint("tttt.toString()");
                    debugPrint("assddddsds${temp}csdjbsbdfjsbhjfbhjfbjdbjb");
                    // testValue = val.toString();
                    debugPrint(val.toString());
                    debugPrint(selectedDocType.value.toString());
                  });

//                   // setState((){
//                   //   selectedDocType.value=val;
//                   // });
// debugPrint(selectedDocType.value);
                },
                value: temp,
              ),
            )),
      );
    });
  }

  void getAllUploadedDoc() async {
    var temp = await AppPreference().profileHash;
    var res = await http
        .post(Uri.parse(OnitUrl.getAllUserFile), body: {"profile_hash": temp});

    debugPrint(res.statusCode.toString());
    debugPrint(temp.toString());
    debugPrint(res.body.toString());
    if (res.statusCode == 200) {
      UploadedDocumentModal modal =
          UploadedDocumentModal.fromJson(jsonDecode(res.body));
      setState(() {
        uploadedDocList.value = modal.data;
      });
      uploadedDocList.value = modal.data;
    }
  }

  Future<void> _launchUrl(String _url) async {
    var temp = Uri.parse(_url);
    if (await canLaunchUrl(temp)) {
      // await launchUrl(Uri.parse("http://pub.dev/packages/url_launcher"));
      await launchUrl(Uri.parse(_url));
    }
    // if (!await launchUrl(temp)) {
    //   debugPrint("934289304780238794294972034702804");
    //   throw 'Could not launch $_url';
    // }
  }
}

class ViewDocumentPdf extends StatefulWidget {
  ViewDocumentPdf({Key? key, required this.url}) : super(key: key);
  String url;
  @override
  State<ViewDocumentPdf> createState() => _ViewDocumentPdfState();
}

class _ViewDocumentPdfState extends State<ViewDocumentPdf> {
  PDFDocument? document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  void dispose() {
    // document.clearImageCache();
    // document = null;
    super.dispose();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.url);
    setState(() async => document = await PDFDocument.fromURL(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: PDFViewer(
          document: document!,
          zoomSteps: 1,
        ),
      ),
    ));
  }
}
