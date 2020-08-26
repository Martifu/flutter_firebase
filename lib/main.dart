import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ejemplos/controllers/bindings/authbinding.dart';
import 'package:firebase_ejemplos/utils/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      home: Root(),
      theme: ThemeData.dark(),
    );
  }
}