import 'package:flutter/material.dart';
import 'package:onit/pages/auth/forget_Password/forget_password_screen.dart';

import '../component/app_tab_menu.dart';
import '../pages/Upload Doc/upload_screen.dart';
import '../pages/auth/login/login_screen.dart';
import '../pages/auth/splash/splash_screen.dart';
import '../pages/auth/user_registration/registration_Screen.dart';
import '../pages/auth/verify_otp/otp_screen.dart';

class AppRoutes {
  static const none = "/";
  static const splashPage = '/splash_page';
  static const homepage = 'lib/pages/home.dart';
  static const loginPage = 'lib/pages/auth/login/login_screen.dart';
  static const forgetPasswordScreen =
      "lib/pages/auth/forget_Password/forget_password_screen.dart";
  static const registrationScreen =
      "lib/pages/auth/user_registration/registration_Screen.dart";
  static const uploadDocScreen = "lib/pages/Upload Doc/upload_screen.dart";
  static const otpScreen = "lib/pages/auth/verify_otp/otp_screen.dart";
//auth
}

appGeneratedRoutes(RouteSettings settings) {
  switch (settings.name) {
    //splash
    case AppRoutes.splashPage:
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          builder: (BuildContext context) => const SplashPage());
    //registration Screen
    case AppRoutes.registrationScreen:
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          builder: (BuildContext context) => const RegistrationScreen());
    case AppRoutes.uploadDocScreen:
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          builder: (BuildContext context) => const DocumentUploadScreen());
    //otpScreen
    case AppRoutes.otpScreen:
      String userName = "";
      try {
        userName = settings.arguments as String;
      } catch (e) {}
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          builder: (BuildContext context) => VerifyOtp(
                username: userName,
              ));

    //homePage
//homePage
    case AppRoutes.loginPage:
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          builder: (BuildContext context) => const LoginScreen());
    case AppRoutes.homepage:
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          builder: (BuildContext context) => AppTabMenu(
                menuItemsList: const [
                  "My Orders",

                  "Update Profile",
                  "Upload Doc",
                  // "Other Details",
                ],
                onItemClick: (int index) {},
                selectedIndex: 0,
              )); //HomePage());
    case AppRoutes.forgetPasswordScreen:
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          builder: (BuildContext context) => const ForgetPasswordScreen());

    default:
      return MaterialPageRoute(
          settings:
              RouteSettings(name: settings.name, arguments: settings.arguments),
          // builder: (BuildContext context) => const HomePage());
          builder: (BuildContext context) => const LoginScreen());
  }
}
