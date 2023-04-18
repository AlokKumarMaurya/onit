import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onit/utilities/app_navigator.dart';
import 'package:onit/utilities/app_prefereces.dart';
import 'package:onit/utilities/app_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await GetStorage.init(AppPreference.STORAGE_NAME);
   await setupLocator();
  } catch (e) {
    debugPrint("MainException: ${e.toString()}");
  }
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  GetIt locator = GetIt.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Onit',
      locale: const Locale('en', 'US'),
      navigatorKey: locator<AppNavigator>().navigationKey,
     debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashPage,
      onGenerateRoute: (RouteSettings settings) =>
          appGeneratedRoutes(settings)
    );
  }
}


