import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/app/shared/binding/initial_binding.dart';
import 'package:task/firebase_options.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.SPLASH,
        getPages: AppPages.pages,
        initialBinding: InitialBinding(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
