import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../infrastructure/commons/user-type.dart';
import '../../../../infrastructure/route/route-name.dart';
import '../models/seller-home-dto.dart';
import '../models/seller-home-view-model.dart';
import '../repository/seller-home-repository.dart';


class SellerHomePageController extends GetxController {
  final SellerHomeRepository _repository = SellerHomeRepository();
  final SharedPreferences _preferences = Get.find<SharedPreferences>();
  final RxList<SellerHomeViewModel> products = RxList();
  RxBool isGetProductsLoading = false.obs;
  RxBool isGetProductsRetry = false.obs;
  RxBool isActiveDisable = false.obs;
  Rx<RangeValues> rangeSliderValues = const RangeValues(0, 0).obs;
  RxInt maxPrice = RxInt(0);
  RxInt minPrice = RxInt(0);
  int maxFilter = 0;
  int minFilter = 0;
  RxSet<String> filterColorsList = RxSet();
  RxInt filterColorIndex = RxInt(-1);
  String filterColor = '';
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProducts(
      searchText: searchTextController.text,
    );
    filter();
  }

  Future<void> getProducts({required String searchText}) async {
    isGetProductsRetry.value = false;
    isGetProductsLoading.value = true;
    final result = await _repository.getProducts(
      sellerId:UserType.userId!,
      minPrice: minFilter,
      maxPrice: maxFilter,
      search: searchText,
      color: filterColor,
    );
    isGetProductsLoading.value = false;
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
    final result = await _repository.getProductsBySortPrice(sellerId: UserType.userId!);
    result.fold((left) {
      Get.showSnackbar(GetSnackBar(
        message: '${'error'} : $left',
        duration: const Duration(seconds: 2),
      ));
    }, (right) {
      if (right.isNotEmpty) {
        for(final product in right){
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

  Future<void> addButton() async {
    final result = await Get.toNamed(
        RouteName.seller + RouteName.addSeller);
    if (result != null) {
      final SellerHomeViewModel product = SellerHomeViewModel.fromJson(result);
      products.add(product);
      filter();
    }
  }

  void onFilterColorTap(int index){
    filterColorIndex.value = index;
  }
  void clearSearch()=>searchTextController.clear();

  void logOutButton() {
    UserType.userId = null;
    UserType.isSeller = null;
    _preferences.clear();
    Get.offAllNamed(RouteName.login);
  }

  Future<void> SwichButton(newValue, SellerHomeViewModel product) async {
    SellerHomeDto dto =SellerHomeDto(
      product.image,
      product.description,
      product.colors,
      id: product.id,
      tittle: product.tittle,
      price: product.price,
      sellerId: UserType.userId!,
      count: product.count,
      isActive: newValue,
    );
    isActiveDisable.value = true;
    final result = await _repository.patchProduct(dto: dto);
    isActiveDisable.value = false;
    result.fold(
            (left) => Get.showSnackbar(GetSnackBar(
          message: '${'error'} : $left',
          duration: const Duration(seconds: 2),
        )), (right) {
      int index = products.indexWhere((element) => element.id == right.id);
      products[index] = right;
    });
  }

  void changeLanguage({required Locale locale}) => Get.updateLocale(locale);

  void rangePrice(newValues) {
    rangeSliderValues.value = newValues;
  }

  Future<void>edit(int id) async {
    final result = await Get.toNamed(
        RouteName.seller + RouteName.editProduct,
        parameters: {'id': id.toString()});

    if (result != null) {
      SellerHomeViewModel product =SellerHomeViewModel.fromJson(result);
      int index = products.indexWhere((element) => element.id == product.id);
      products[index] = product;
      filter();
    }
  }

  Future<void> filterButton() async {
    maxFilter = rangeSliderValues.value.end.round();
    minFilter = rangeSliderValues.value.start.round();
    if(filterColorIndex.value != -1){
      filterColor = filterColorsList.toList()[filterColorIndex.value];
    }
    getProducts(
      searchText: searchTextController.text,
    );
  }

  Future<void> removeFilterButton() async {
    maxFilter = 0;
    minFilter = 0;
    filterColor = '';
    filterColorIndex.value = -1;
    getProducts(
      searchText: searchTextController.text,
    );
  }

  Future<void> search(String value) async {
    getProducts(
      searchText: value,
    );
  }
}
