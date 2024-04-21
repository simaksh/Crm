import 'package:get/get.dart';
import '../controller/detail-customer-controller.dart';

class DetailCustomerBinding extends Bindings {
  @override
  void dependencies() {
    final int productId = int.parse(Get.parameters['productId']!);
    Get.lazyPut(() => DetailCustomerPageController(productId: productId));
  }

}