import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onit/data_layer/repository/registration_repo.dart';

import '../../../component/text_form_field.dart';
import '../../../model/registration_Model.dart';
import '../../../utilities/app_nav.dart';
import '../../../utilities/app_prefereces.dart';
import '../../../utilities/app_routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool isCheckedTerms = false;
  bool register_button_loader = false;

  RegistrationModel? register_model;

  register() async {

    setState(() {
      register_button_loader = true;
    });

    var userDataResponse = await RegistrationRepo().Register(
        name: _name.text,
        email: _email.text,
        password: _password.text,
        phoneNumber: _phone.text);
    if (userDataResponse != null) {
      setState(() {
        register_model = userDataResponse;
        if (register_model?.status == 1) {
          Fluttertoast.showToast(msg: register_model!.message);
          AppPreference().saveProfileHash(register_model!.data[0].profileHash);
          AppNav.toNamed(AppRoutes.otpScreen,arguments: _email.text);
          _name.clear();
          _email.clear();
          _phone.clear();
          _password.clear();
        } else {
          Fluttertoast.showToast(msg: register_model!.message);
        } register_button_loader = false;
      });

    } else {
      setState(() { register_button_loader = false;});
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
                height: MediaQuery.of(context).size.height / 7,
              ),
              const Text(
                "SIGNUP!",
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
                      const Text("Your Name"),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(
                        cotroller: _name,
                        hintText: "Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Your Email"),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(
                        cotroller: _email,
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Your Password"),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(
                        cotroller: _password,
                        hintText: "password",
                        obsecure: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Your Phone"),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(
                        cotroller: _phone,
                        hintText: "Phone",
                        prefixIcon: Icon(
                          Icons.settings_cell,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Checkbox(
                                value: isCheckedTerms,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedTerms = value!;
                                    print(isCheckedTerms.toString());
                                  });
                                }),
                          ),
                          const Text("I agree all the statements"),
                          const Expanded(
                              child: Text(
                            "Terms of services",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              register_button_loader== false?Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),

                          //////// HERE
                        ),
                        onPressed: () {
                          if (_name.text.isNotEmpty) {
                            if (_email.text.isNotEmpty) {
                              if (_password.text.isNotEmpty) {
                                if (_phone.text.isNotEmpty) {
                                  if (isCheckedTerms == true) {
                                    register();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Check Terms of services.");
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Enter your phone number first!");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Enter your password first!");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Enter your email first!");
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Enter your name first!");
                          }
                        },
                        child: const Text("Register")),
                  ),
                ],
              ):Center(child: CircularProgressIndicator(),),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Already Have Account ?",
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNav.toNamed(AppRoutes.loginPage);
                    },
                    child: const Text(
                      "LOGIN",
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
