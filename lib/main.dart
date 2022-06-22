import 'package:cookkug/controllers/cook_controller.dart';
import 'package:cookkug/controllers/cookkug_user_controller.dart';
import 'package:cookkug/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/main_screen.dart';
import 'firebase_options.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COOKKUG',
      theme: ThemeData(),
      home: LoginScreen(),
      initialBinding: BindingsBuilder((){
        Get.put(CookkugUserController());
      }),
    );
  }
}
