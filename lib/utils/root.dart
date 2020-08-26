import 'package:firebase_ejemplos/controllers/authController.dart';
import 'package:firebase_ejemplos/controllers/userController.dart';
import 'package:firebase_ejemplos/screens/home.dart';
import 'package:firebase_ejemplos/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {

  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_){
        if (Get.find<AuthController>().user != null) {
          return Home();
        }  else {
          return Login();
        } 
      },
    );
  }
}