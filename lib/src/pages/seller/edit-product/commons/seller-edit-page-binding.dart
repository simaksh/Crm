import 'package:get/get.dart';

import '../controller/seller-edit-controller.dart';

class SellerEditPageBinding extends Bindings {
  @override
  void dependencies() {
    final int productId = int.parse(Get.parameters['id']!);
    Get.lazyPut(() => SellerEditPageController(productId));
  }
}