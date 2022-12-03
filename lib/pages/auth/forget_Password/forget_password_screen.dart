import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../component/text_form_field.dart';
import '../../../data_layer/repository/registration_repo.dart';
import '../../../model/forget_password_model.dart';
import '../../../utilities/app_nav.dart';
import '../../../utilities/app_routes.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {


  final _email=TextEditingController();

  bool isCheckedTerms=false;
  ForgetPasswordModel? forgetPassword_model;

  bool forget_button_loader=false;
  forgetPassword() async {

    setState(() {
      forget_button_loader = true;
    });

    var userDataResponse = await RegistrationRepo().forgetPassword(username: _email.text);
    if (userDataResponse != null) {
      setState(() {
        forgetPassword_model = userDataResponse;
        if (forgetPassword_model?.status == 1) {
          Fluttertoast.showToast(msg: forgetPassword_model!.message);
          AppNav.toNamed(AppRoutes.otpScreen,arguments:_email.text );


          _email.clear();

        } else {
          Fluttertoast.showToast(msg: forgetPassword_model!.message);
        } forget_button_loader = false;
      });

    } else {
      setState(() { forget_button_loader = false;});
    }
  }
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
                "LOGIN!",
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
                    const  Text("Your Email"),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(cotroller: _email,hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
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

if(_email.text.isNotEmpty){
  forgetPassword();
}else{
  Fluttertoast.showToast(msg: "Enter your email first!");
}


                      },
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text("Verify OTP"),
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
}
