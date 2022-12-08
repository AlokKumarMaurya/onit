import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onit/pages/resetPass/resetPasswordScreen.dart';

import '../../../component/text_form_field.dart';
import '../../../data_layer/repository/registration_repo.dart';
import '../../../model/forget_password_model.dart';
import '../../../model/reset_pass.dart';
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

    var userDataResponse = await RegistrationRepo().SendResetPasswordOtp(_email.text);
    if (userDataResponse != null) {
      setState(() {
        ResetOtpsend modal=userDataResponse;
        if (modal.status == 1) {
          Fluttertoast.showToast(msg: modal.message);
          //AppNav.toNamed(AppRoutes.otpScreen,arguments:_email.text );

Get.to(VerifyResetOtp(username: _email.text));
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







class VerifyResetOtp extends StatefulWidget {
  const VerifyResetOtp({required this.username, Key? key}) : super(key: key);
  final String username;

  @override
  State<VerifyResetOtp> createState() => _VerifyResetOtpState();
}

class _VerifyResetOtpState extends State<VerifyResetOtp> {
  final _otp = TextEditingController();
  bool verify_button_loader = false;
  ResetPasswordModel? verifyOtp_model;
  bool forget_button_loader = false;

  sendOtpAgain() async {
    setState(() {
      forget_button_loader = true;
    });

    var userDataResponse =
    await RegistrationRepo().SetNewPassword(username: widget.username);
    if (userDataResponse != null) {
      setState(() {
        verifyOtp_model = userDataResponse;
        if (verifyOtp_model?.status == 1) {
          Fluttertoast.showToast(msg: verifyOtp_model!.message);
        } else {
          Fluttertoast.showToast(msg: verifyOtp_model!.message);
        }
        forget_button_loader = false;
      });
    } else {
      setState(() {
        forget_button_loader = false;
      });
    }
  }

  verifyOTP() async {
    setState(() {
      verify_button_loader = true;
    });

    var userDataResponse = await RegistrationRepo()
        .verifyResetOtp(username: widget.username, otp: _otp.text);
    if (userDataResponse != null) {
      print(userDataResponse);
      setState(() {
        verifyOtp_model = userDataResponse;
        if (verifyOtp_model?.status == 1) {
          // verifyOtp_model.data[0].profileHash
          // AppNav.toNamed(AppRoutes.homepage);
          Get.to(ResetPasswordScreen( profileHash: verifyOtp_model!.data[0].profileHash,));
          print("111111111111111111111"); //Navigator.push(context,MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
          print(verifyOtp_model);
          _otp.clear();
        } else {
          Fluttertoast.showToast(msg: verifyOtp_model!.message);
        }
        verify_button_loader = false;
      });
    } else {
      setState(() {
        verify_button_loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              const Text(
                "Verify OTP",
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
                    children: [
                      Text(
                        "OTP has been sent to your email(${widget.username}).",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Make sure to check spam folder.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Enter OTP",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(
                        cotroller: _otp,
                        hintText: "Enter OTP",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              verify_button_loader == false
                  ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),

                    //////// HERE
                  ),
                  onPressed: () {
                    if (_otp.text.isNotEmpty) {
                      verifyOTP();
                    } else {
                      Fluttertoast.showToast(msg: "Enter you otp first!");
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text("Verify"),
                  ))
                  : Container(
                  margin: EdgeInsets.only(left: 40),
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Do not receive OTP?",
                  ),
                  forget_button_loader == false?TextButton(onPressed: () {
                    sendOtpAgain();
                  }, child: const Text("Send Again")):Container(
                      margin: EdgeInsets.only(left: 40),
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
