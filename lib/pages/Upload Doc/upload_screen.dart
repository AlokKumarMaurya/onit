import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onit/component/text_form_field.dart';
import 'package:onit/utilities/app_nav.dart';
import 'package:http/http.dart' as http;
import '../../api config/api_client.dart';
import '../../api config/onit_url.dart';
import '../../utilities/app_prefereces.dart';

class DocumentUploadScreen extends ConsumerStatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DocumentUploadScreen> createState() =>
      _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends ConsumerState<DocumentUploadScreen> {
  final _alternateNumber = TextEditingController();
  File? file;
  String? filesname;

  /*Future uploadDocument() async {
    String profileHash = AppPreference().profileHash;
    FormData formData = FormData.fromMap({
      "profile_hash": profileHash,
      "doc_type": 1,
      "file": await MultipartFile.fromFile(file!.path, filename: "file"),

    });

    var request = http.MultipartRequest("POST", Uri.parse(OnitUrl.uploadDoucment));
    request.fields['profile_hash'] = profileHash;
    request.fields['doc_type'] =1.toString();
    request.files.add(    http.MultipartFile.fromPath(
        'file',
        File(file!.path).readAsBytesSync(),
        filename: file!.path.split('/').last
    ) );
    var res = await request.send();

    Fluttertoast.showToast(msg: res.statusCode.toString());
    setState(() {});
    // print(("response"+response.toString());
    // // var res = jsonDecode(response.);
    // print(("data is decoded");

  }*/




    Future uploadDocument() async {
      // ApiClient().uploadDocNew(file);
   //
   //  String profileHash = AppPreference().profileHash;
   //  if(file==null || file!.path.isEmpty){
   //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chosse file first")));
   //  }
   //
   //
   // final formData = FormData.fromMap({
   //    'profile_hash': profileHash,
   //    'doc_type': "1",
   //    'file': await   MultipartFile.fromFile(file!.path,
   //        filename: file!.path.split("/").last,)
   //
   //  });
    //
    // var test=http.MultipartRequest(
    //   "POST",Uri.parse(OnitUrl.uploadDoucment)
    // );
    // test.fields.addAll(
    //   {'profile_hash': profileHash,
    // 'doc_type':"1",});
    // test.files.add(await http.MultipartFile.fromPath("file",file!.path,
    //   filename: file!.path.split("/").last,));
    // http.StreamedResponse res=await test.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xffFF9400),
        title: Text("Upload Document"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Center(
              child: Text(
                "Upload Document",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Document Type",
            ),
            const SizedBox(
              height: 10,
            ),
            textFormField(
              cotroller: _alternateNumber,
              hintText: 'Alternate no.',
              prefixIcon: Icon(Icons.phone),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
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
                          filesname = file!.path.split('/').last;
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      color: Colors.grey,
                      child: Center(
                          child: Text(
                        "Choose File",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  Text(filesname != null ? "$filesname" : "--")
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  uploadDocument();
                  // AppNav.pop();
                },
                child: Text("Upload"))
          ],
        ),
      )),
    );
  }
}
