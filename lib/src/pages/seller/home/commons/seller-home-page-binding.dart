import 'package:get/get.dart';

import '../controller/seller-home-controller.dart';

class SellerHomePageBinding extends Bindings{
  @override
  void dependencies() =>Get.lazyPut(() => SellerHomePageController());

}