import 'package:get/get.dart';

import '../controller/shopping-cart-controller.dart';


class ShoppingCartBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ShoppingCartPageController());
  }

}