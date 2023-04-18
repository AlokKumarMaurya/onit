import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/pages/auth/login/login_screen.dart';
import '../../component/text_form_field.dart';
import '../../data_layer/repository/login_repository.dart';
import '../../model/password_reset_reset.dart';
import '../../utilities/app_nav.dart';
import '../../utilities/app_routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key,required this.profileHash}) : super(key: key);
final String profileHash;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}




class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _password=TextEditingController();
  bool forget_button_loader=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/7,
              ),
              const Text(
                "Reset Password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: 10,
                      ),
                      const  Text("New Password"),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(cotroller: _password,hintText: "Password",
                        prefixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                        ),
                        obsecure: true,
                      ),


                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  forget_button_loader==false? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),

                        //////// HERE
                      ),
                      onPressed: () {

                        if(_password.text.isNotEmpty){
                          print("Button pressed");
                        forgetPassword(_password.text,widget.profileHash);
                        }else{
                          Fluttertoast.showToast(msg: "Enter new password first");
                        }


                      },
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text("Change password"),
                      )):Container(
                      margin: EdgeInsets.only(left: 40),
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      )),

                  GestureDetector(
                    onTap: () {
                      AppNav.toNamed(AppRoutes.loginPage);
                    },
                    child: Text("Login",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Do not have account ? ",
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(onTap: (){
                    AppNav.toNamed(AppRoutes.registrationScreen);
                  },
                    child: Text(
                      "Create One",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void forgetPassword(String pass ,String profileHas) async{
    Get.defaultDialog(
      title: "",
      content: CircularProgressIndicator()
    );
    var response=await LoginRepository().ResetPassword(pass,profileHas);
    if(response!=null){
      PasswordResetResponse modal=response;
      print(modal.data);
      print(modal.message);
      Fluttertoast.showToast(msg: modal.message);
      Get.back();
      Get.offAll(LoginScreen());
    }
  }
}
