import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlutterWebRTCExample());
}

class FlutterWebRTCExample extends StatelessWidget {
  const FlutterWebRTCExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: Colors.pink.shade900,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24)
        ),
        scaffoldBackgroundColor: Colors.black
      ),
      title: "Flutter Meet",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
