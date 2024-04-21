import 'package:get/get.dart';

import '../controller/login-page-controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => LoginPageController());
}
