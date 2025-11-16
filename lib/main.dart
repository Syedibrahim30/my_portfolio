import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/main_screen_folder/controller/main_controller.dart';
import 'package:my_portfolio/my_app.dart';

void main() {
  Get.put(MainController());
  runApp(const MyApp());
}
