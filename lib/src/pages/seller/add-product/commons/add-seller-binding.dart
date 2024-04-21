import 'package:get/get.dart';

import '../controller/add-seller-page-controller.dart';
class AddSellerBinding extends Bindings{
  @override
  void dependencies() =>Get.lazyPut(() =>AddSellerPageController());

}