import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';
import 'package:my_portfolio/my_app.dart';

void main() {
  Firebase.initializeApp();
  Get.put(MainController());
  runApp(const MyApp());
}
