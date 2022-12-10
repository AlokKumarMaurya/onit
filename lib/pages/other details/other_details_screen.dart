import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/api%20config/api_client.dart';
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



  onSave() async {
    bool allValid = true;
    //If any form validation function returns false means all forms are not valid
    contactForms.forEach((element){
      if(element._nameController.text.isEmpty ){
        allValid=false;
      }
    });

if(contactForms!=null){
  Get.dialog(
    barrierDismissible: false,
    Container(
      color: Colors.transparent,
      height: 200,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    )
  );
  for (int i = 0; i < contactForms.length; i++) {
    ContactFormItemWidget item = contactForms[i];
// debugPrint("000000000000000000000");
// debugPrint((item.contactModel.name !=null && item.contactModel.name.isNotEmpty && item.contactModel.name!="").toString());

    if(item.contactModel.name !=null && item.contactModel.name.isNotEmpty && item.contactModel.name!=""){
      valueData[i]=item.contactModel.name;
    }
    // debugPrint(item.contactModel.name.toString());
    // debugPrint("Number: ${item.contactModel.number}");
    // debugPrint("Email: ${item.contactModel.email}");
  }

 var res=await ApiClient().UpdateUserOtherDetails(valueData,keyData);
  if(res!=null){
    Get.back();
  }
    }else{
  Fluttertoast.showToast(msg: "No data found");
}






    // if (allValid) {
    //   for (int i = 0; i < contactForms.length; i++) {
    //     ContactFormItemWidget item = contactForms[i];
    //     debugPrint("Name: ${item.contactModel.name}");
    //     debugPrint("Number: ${item.contactModel.number}");
    //     debugPrint("Email: ${item.contactModel.email}");
    //   }
    //   //Submit Form Here
    //
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Form submited succeffully"),duration: Duration(seconds: 2),backgroundColor: Colors.green,),);
    //
    //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
    //   // SingleChildScrollView(
    //   //   child: Container(
    //   //     height: 150,
    //   //     child: ListView.builder(
    //   //       physics: NeverScrollableScrollPhysics(),
    //   //       shrinkWrap: true,
    //   //       itemCount: contactForms.length,itemBuilder: (_,index){
    //   //       return Padding(
    //   //         padding: const EdgeInsets.all(8.0),
    //   //         child: Card(
    //   //           child: Container(
    //   //             child: Text("${contactForms[index]._nameController.text}"),
    //   //           ),
    //   //         ),
    //   //       );
    //   //     },),
    //   //   ),
    //   // ),
    //   //
    //   //   duration: Duration(seconds: 2),backgroundColor: Colors.green,),);
    //
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Form updated"),duration: Duration(seconds: 2),));
    //   debugPrint("Form is Not Valid");
    // }
  }

  //Delete specific form
  onRemove(ContactModel contact) {
    print(contact.id);
    setState(() {
      contactForms.removeAt(contact.id);
    });
    // setState(() {
    //   setState(() {
    //     int index=contactForms.indexWhere((element) => element.contactModel.id==contact.id);
    //     if(contactForms != null){
    //       contactForms.removeAt(index);
    //     }
    //   });
    // });
  }

  //Add New Form
  onAdd(String title,String initialValue) {
    setState(() {
      ContactModel _contactModel =
      ContactModel(name: "", email: "", number: "", address: "",id: contactForms.length);
      contactForms.add(ContactFormItemWidget(
        initialText: initialValue,
        title: title,
        index: contactForms.length,
        contactModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }




  List<ContactFormItemWidget> contactForms = List.empty(growable: true);
List keyData=List.empty(growable: true);
List valueData=List.empty(growable: true);

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


      // userOtherData.forEach((element) {onAdd(userOtherData);});
if(userOtherData!=null){
  for(int i=0;i<userOtherData.length;i++){
    onAdd(userOtherData[i].title,userOtherData[i].value??" ");
    keyData.add(userOtherData[i].typeId);
    valueData.add(userOtherData[i].value);
  }
}

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
            // get_user_other_data_model != null
            //     ? userOtherData.isNotEmpty
            //         ? ListView.builder(
            //             shrinkWrap: true,
            //             physics: NeverScrollableScrollPhysics(),
            //             itemCount: userOtherData.length,
            //             itemBuilder: (context, index) {
            //               var otherData = userOtherData[index];
            //               return Card(
            //                   elevation: 10,
            //                   child: Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 8.0, vertical: 25),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.stretch,
            //                         children: [
            //                           Text(
            //                             "${otherData.title}",
            //                             style: TextStyle(
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                           const SizedBox(
            //                             height: 10,
            //                           ),
            //                           Container(
            //                             padding: EdgeInsets.all(10),
            //                             decoration: BoxDecoration(
            //                                 borderRadius:
            //                                     BorderRadius.circular(5),
            //                                 border: Border.all(
            //                                     width: 0.5,
            //                                     color: Colors.grey)),
            //                             child: Text("${otherData.value}"),
            //                           )
            //                         ],
            //                       )
            //                     /*Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text("Alternate Number"),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         textFormField(cotroller: _alterateContactNumber,hintText: "Alternate Number",
            //           prefixIcon:Container()
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         const  Text("Gender"),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         textFormField(cotroller: _gender,hintText: "Gender",
            //           prefixIcon:Container()
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         const Text("Nationality"),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         textFormField(cotroller: _nationality,hintText: "Nationality",
            //           prefixIcon:Container()
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //
            //
            //
            //
            //
            //
            //         const Text("Qualification"),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         textFormField(cotroller: _qualification,hintText: "Qualification",
            //           prefixIcon:Container()
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         const Text("Text Field Text"),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         textFormField(cotroller: _textFieldText,hintText: "Text Field Text",
            //           prefixIcon: Container()
            //         ),
            //
            //
            //
            //
            //
            //
            //
            //
            //
            //       ],
            //     ),*/
            //                       ));
            //             },
            //           )
            //         : const Center(
            //             heightFactor: 10, child: Text("No Data Found"))
            //     : const ShimmerWidget(),
            // const SizedBox(
            //   height: 10,
            // ),

           contactForms!=null? contactForms.isNotEmpty
                ? Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: contactForms.length,
                      itemBuilder: (_, index) {
                        return contactForms[index];
                      }),
                ):const ShimmerWidget():Container(),




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
                        onSave();
                        // AppNav.toNamed(AppRoutes.homepage);
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





class ContactFormItemWidget extends StatefulWidget {
  ContactFormItemWidget(
      {Key? key,
        required this.contactModel,
        required this.onRemove,
        this.index,
      required this.title,
      required this.initialText})
      : super(key: key);

  final index;
  ContactModel contactModel;
  final Function onRemove;
  final state = _ContactFormItemWidgetState();
final title;
final initialText;
  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _nameController = TextEditingController();
  // TextEditingController _contactController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _addressController = TextEditingController();

}

class _ContactFormItemWidgetState extends State<ContactFormItemWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formKey,
        child: Card(
            elevation: 10,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 25),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${widget.title}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: widget._nameController,
                      // initialValue: widget.contactModel.name,
                      onChanged: (value) => widget.contactModel.name = value,
                      onSaved: (value) =>
                      widget.contactModel.name = value.toString(),
                      // initialValue: "${widget.initialText}",
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(),
                        hintText: "${widget.initialText}",
                        // labelText: "${widget.initialText}",
                      ),
                    )
                  ],
                )
              /*Column(
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
            ))
        // Container(
        //   padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     border: Border.all(color: Colors.black54),
        //     borderRadius: BorderRadius.all(Radius.circular(12)),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.2),
        //         spreadRadius: 2,
        //         blurRadius: 10,
        //         offset: Offset(0, 3), // changes position of shadow
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Row(
        //         mainAxisSize: MainAxisSize.max,
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             "${widget.index}",
        //             style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 16,
        //                 color: Colors.orange),
        //           ),
        //           Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               TextButton(
        //                   onPressed: () {
        //                     setState(() {
        //                       //Clear All forms Data
        //                       widget.contactModel.name = "";
        //                       widget.contactModel.number = "";
        //                       widget.contactModel.email = "";
        //                       widget._nameController.clear();
        //                       widget._contactController.clear();
        //                       widget._emailController.clear();
        //                     });
        //                   },
        //                   child: Text(
        //                     "Clear",
        //                     style: TextStyle(color: Colors.blue),
        //                   )),
        //               TextButton(
        //                   onPressed: () => widget.onRemove(),
        //                   child: Text(
        //                     "Remove",
        //                     style: TextStyle(color: Colors.blue),
        //                   )),
        //             ],
        //           ),
        //         ],
        //       ),
        //       TextFormField(
        //         controller: widget._nameController,
        //         // initialValue: widget.contactModel.name,
        //         onChanged: (value) => widget.contactModel.name = value,
        //         onSaved: (value) =>
        //         widget.contactModel.name = value.toString(),
        //         decoration: InputDecoration(
        //           contentPadding: EdgeInsets.symmetric(horizontal: 12),
        //           border: OutlineInputBorder(),
        //           hintText: "Enter Name",
        //           labelText: "Name",
        //         ),
        //       ),
        //       // SizedBox(
        //       //   height: 8,
        //       // ),
        //       // TextFormField(
        //       //   controller: widget._contactController,
        //       //   onChanged: (value) => widget.contactModel.number = value,
        //       //   onSaved: (value) =>
        //       //   widget.contactModel.name = value.toString(),
        //       //   decoration: InputDecoration(
        //       //     contentPadding: EdgeInsets.symmetric(horizontal: 12),
        //       //     border: OutlineInputBorder(),
        //       //     hintText: "Enter Number",
        //       //     labelText: "Number",
        //       //   ),
        //       // ),
        //       // SizedBox(
        //       //   height: 8,
        //       // ),
        //       // TextFormField(
        //       //   controller: widget._emailController,
        //       //   onChanged: (value) => widget.contactModel.email = value,
        //       //   onSaved: (value) =>
        //       //   widget.contactModel.email = value.toString(),
        //       //   decoration: InputDecoration(
        //       //     contentPadding: EdgeInsets.symmetric(horizontal: 12),
        //       //     border: OutlineInputBorder(),
        //       //     hintText: "Enter Email",
        //       //     labelText: "Email",
        //       //   ),
        //       // ),
        //       // SizedBox(height: 8,),
        //       // TextFormField(
        //       //     onChanged: (value)=>widget.contactModel.address=value,
        //       //     onSaved: (value)=>widget.contactModel.address.toString(),
        //       //     controller: widget._addressController,
        //       //     decoration: InputDecoration(
        //       //         hintText: "Addrress",
        //       //         labelText: "Address"
        //       //     )
        //       //
        //       // )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}




class ContactModel {
  int id;
  String name;
  String number;
  String email;
  String? address;

  ContactModel(
      {required this.name,
        required this.number,
        required this.email,
        this.address,required this.id});
}