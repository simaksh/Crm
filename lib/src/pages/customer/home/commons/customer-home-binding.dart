import 'package:get/get.dart';
import '../controller/customer-page-controller.dart';


class CustomerHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerHomePageController());
  }

}