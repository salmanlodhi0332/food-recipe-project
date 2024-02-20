import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_recipe/MVC/view/welcomeScreen.dart';
import 'package:food_recipe/constant/theme.dart';
import 'package:food_recipe/helper/data_storage.dart';
import 'package:get/get.dart';
import 'constant/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DataStroge.getInstance.initiateSession();
  final Data = Get.put(DataStorage());
  loadConfig();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());

  Get.put(ThemeHelper());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          home: child,
        );
      },
      child: WelcomeScreen(),
    );
  }
}

Future<void> loadConfig() async {
  try {
    String configString = await rootBundle.loadString('config/config.json');
    Map<String, dynamic> configJson = json.decode(configString);
    Constants.API_HOST = configJson['api_host'];
  } catch (e) {
    print(e);
    print("Configuration file does not exists or is not valid");
    exit(0);
  }
}
