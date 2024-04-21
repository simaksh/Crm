import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../infrastructure/commons/user-type.dart';
import '../../../../infrastructure/route/route-name.dart';

import '../models/customer-product-view-model.dart';
import '../repository/customer-repository.dart';

class CustomerHomePageController extends GetxController {
  final CustomerRepository _repository = CustomerRepository();
  final SharedPreferences _preferences = Get.find<SharedPreferences>();
  RxList<CustomerProductViewModel> products = RxList();
  RxBool isGetProductsLoading = false.obs;
  RxBool isGetProductsRetry = false.obs;
  Rx<RangeValues> rangeSliderValues = const RangeValues(0, 0).obs;
  RxInt maxPrice = RxInt(0);
  RxInt minPrice = RxInt(0);
  int maxFilter = 0;
  int minFilter = 0;
  RxSet<String> filterColorsList = RxSet();
  RxInt filterColorIndex = RxInt(-1);
  String filterColor = '';
  RxInt allProductsSelectedCount = RxInt(0);
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProducts(
      searchText: searchTextController.text,
    );
    getAllProductsSelectedCount();
    filter();
  }


  Future<void> getProducts({required String searchText}) async {
    isGetProductsLoading.value = true;
    final result = await _repository.getProducts(
      minPrice: minFilter,
      maxPrice: maxFilter,
      search: searchText,
      color: filterColor,
    );
    isGetProductsLoading.value = false;
    isGetProductsRetry.value = false;
    result.fold((left) {
      isGetProductsRetry.value = true;
      Get.showSnackbar(GetSnackBar(
        message: '${'error'} : $left',
        duration: const Duration(seconds: 2),
      ));
    }, (right) {
      products.clear();
      products.addAll(right);
    });
  }

  Future<void> filter() async {
    final result = await _repository.getProductsBySortPrice();
    result.fold((left) {
      Get.showSnackbar(GetSnackBar(
        message: '${'error'} : $left',
      ));
    }, (right) {
      if (right.isNotEmpty) {
        for (final product in right) {
          filterColorsList.addAll(product.colors);
        }
        minPrice.value = right[0].price;
        maxPrice.value = right[(right.length - 1)].price;
      }
      if (maxPrice.value == minPrice.value) {
        maxPrice.value = maxPrice.value + 1;
      }
      rangeSliderValues.value =
          RangeValues(minPrice.value.toDouble(), maxPrice.value.toDouble());
    });
  }

  Future<void> getAllProductsSelectedCount() async {
    final result =
    await _repository.getSelectedProducts(userId: UserType.userId ?? 0);
    result.fold(
            (left) => Get.showSnackbar(
          GetSnackBar(
            message: '${'error'} : $left',
            duration: const Duration(seconds: 2),
          ),
        ), (right) {
      allProductsSelectedCount.value = 0;
      for (final product in right) {
        allProductsSelectedCount.value =
            allProductsSelectedCount.value + product.selectedCount;
      }
    });
  }

  void rangePrice(newValues) {
    rangeSliderValues.value = newValues;
  }

  void onFilterColorTap(int index) {
    filterColorIndex.value = index;
  }


  Future<void> logOutButton() async {
    UserType.userId = null;
    UserType.isSeller = null;
    _preferences.clear();
    Get.offAllNamed(RouteName.login);
  }

  void productButton(int id) async {
    final result = await Get.toNamed(
      RouteName.customer + RouteName.customerDetails,
      parameters: {'productId': id.toString()},
    );
    if (result != null) {
      allProductsSelectedCount.value =
          allProductsSelectedCount.value + result as int;
    }
  }

  void filterButton() {
    maxFilter = rangeSliderValues.value.end.round();
    minFilter = rangeSliderValues.value.start.round();
    if(filterColorIndex.value != -1){
      filterColor = filterColorsList.toList()[filterColorIndex.value];
    }
    getProducts(
      searchText: searchTextController.text,
    );
  }

  void removeFilterButton() {
    maxFilter = 0;
    minFilter = 0;
    filterColor = '';
    filterColorIndex.value = -1;
    getProducts(
      searchText: searchTextController.text,
    );
  }

  void search(String value) {
    getProducts(
      searchText: value,
    );
  }

  void changeLanguage({required Locale locale}) => Get.updateLocale(locale);

  Future<void> shoppingCartButton() async {
    await Get.toNamed(
      RouteName.customer + RouteName.shopIngCart,
    );
    getProducts(searchText: searchTextController.text);
    getAllProductsSelectedCount();
    filter();
  }
}
