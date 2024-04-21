import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/src/infrastructure/commons/user-type.dart';

import 'src/app.dart';


Future<void> main() async{
  final preferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(preferences);
  UserType.isSeller = preferences.getBool('isAdmin');
  UserType.userId = preferences.getInt('id');
  runApp(const App());
}
