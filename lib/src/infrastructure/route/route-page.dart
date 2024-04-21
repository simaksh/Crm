
import 'package:get/get.dart';

import 'package:store/src/infrastructure/route/route-name.dart';
import 'package:store/src/pages/login/views/login-page-view.dart';
import 'package:store/src/pages/seller/edit-product/view/seller-edit-page-view.dart';
import 'package:store/src/pages/seller/home/views/seller-home-page.dart';

import '../../pages/customer/detail/commons/detail-customer-binding.dart';
import '../../pages/customer/detail/views/detail-customer-page-view.dart';
import '../../pages/customer/home/commons/customer-home-binding.dart';
import '../../pages/customer/home/view/customer-page-view.dart';
import '../../pages/customer/shopping-cart/commons/shopping-cart-binding.dart';
import '../../pages/customer/shopping-cart/view/shopping-cart-page-view.dart';
import '../../pages/login/commons/login-page-binding.dart';
import '../../pages/seller/add-product/commons/add-seller-binding.dart';
import '../../pages/seller/add-product/views/add-page-seller-view.dart';
import '../../pages/seller/edit-product/commons/seller-edit-page-binding.dart';
import '../../pages/seller/home/commons/seller-home-page-binding.dart';
import '../../pages/signup/commons/signup-page-binding.dart';
import '../../pages/signup/views/signup-page-view.dart';



class RoutePage {
  static List<GetPage> pages = [

    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginPageBinding(),
      children: [
        GetPage(
          name: RouteName.signup,
          page: () => const SignupPageView(),
          binding: SignupPageBinding(),
        ),
      ],
    ),
    GetPage(
        name: RouteName.seller,
        page: () => const SellerHomePage(),
        binding: SellerHomePageBinding(),
        children: [
          GetPage(
            name: RouteName.addSeller,
            page: () => const SellerAddProductPage (),
            binding: AddSellerBinding(),
          ),
          GetPage(
            name: RouteName.editProduct,
            page: () => const SellerEditPage(),
            binding: SellerEditPageBinding(),
          ),
        ]
    ),
    GetPage(
        name: RouteName.customer,
        page: () => const CustomerHomePage(),
        binding: CustomerHomeBinding(),
        children: [
          GetPage(
            name: RouteName.customerDetails,
            page: () => const DetailCustomerPageView(),
            binding: DetailCustomerBinding(),
          ),
          GetPage(
            name: RouteName.shopIngCart,
            page: () => const ShoppingCartPageView(),
            binding: ShoppingCartBinding(),
          ),
        ]
    ),
  ];
}
