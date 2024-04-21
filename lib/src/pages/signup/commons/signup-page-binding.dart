import 'package:get/get.dart';

import '../controller/signup-page-controller.dart';



class SignupPageBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() =>SignupPageController());
}
