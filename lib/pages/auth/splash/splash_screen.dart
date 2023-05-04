import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/app_nav.dart';
import '../../../utilities/app_prefereces.dart';
import '../../../utilities/app_routes.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      print("Login: ${AppPreference().savedLogin}");

      if (AppPreference().savedLogin) {
        AppNav.offAllToNamed(AppRoutes.homepage);
      } else {
        AppNav.toNamed(AppRoutes.loginPage);
      }

      /* AppNav.toNamed(AppRoutes.loginPage);*/
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(
              "assets/appLogo.png",
            ),
          ),
        ],
      ),
    )));
  }
}
