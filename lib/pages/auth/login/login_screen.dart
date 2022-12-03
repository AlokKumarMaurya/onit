import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onit/utilities/app_prefereces.dart';
import 'package:onit/utilities/app_routes.dart';

import '../../../component/text_form_field.dart';
import '../../../data_layer/repository/login_repository.dart';
import '../../../model/login_model.dart';
import '../../../utilities/app_nav.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool login_button_loader = false;
  LoginModel? login_model;

  login() async {
    setState(() {
      login_button_loader = true;
    });
    var response = await LoginRepository().Login(_email.text, _password.text);
    if (response != null) {
      setState(() {
        login_model = response;
        if (login_model?.status == 1) {
          Fluttertoast.showToast(msg: login_model!.message);
          AppNav.toNamed(AppRoutes.homepage);
          AppPreference().saveProfileHash(login_model!.data[0].profileHash);
          AppPreference().saveLogin(true);
          _email.clear();
          _password.clear();
        } else {
          Fluttertoast.showToast(msg: login_model!.message);
        }
        login_button_loader = false;
      });
    } else {
      setState(() {
        Fluttertoast.showToast(msg: "Check username or password!!!");
        login_button_loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      return exit(0);
    },
      child: Scaffold(
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
                Text(
                  "Login",
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
                        Text("Your Email"),
                        const SizedBox(
                          height: 10,
                        ),
                        textFormField(
                          cotroller: _email,
                          hintText: "Enter your email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Password"),
                        const SizedBox(
                          height: 10,
                        ),
                        textFormField(
                          cotroller: _password,
                          hintText: "Enter your password",
                          obsecure: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    login_button_loader == false
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),

                              //////// HERE
                            ),
                            onPressed: () {
                              if (_email.text.isNotEmpty) {
                                if (_password.text.isNotEmpty) {
                                  login();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Enter your password");
                                }
                              } else {
                                Fluttertoast.showToast(msg: "Enter Email First");
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text("Login"),
                            ))
                        : Container(
                            margin: EdgeInsets.only(left: 40),
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            )),
                    GestureDetector(
                      onTap: () {
                        AppNav.toNamed(AppRoutes.forgetPasswordScreen);
                      },
                      child: Text("FORGET PASSWORD",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Do not have account ?",
                    ),
                    GestureDetector(
                        onTap: () {
                          AppNav.toNamed(AppRoutes.registrationScreen);
                        },
                        child: Text(
                          "CREATE ONE",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
