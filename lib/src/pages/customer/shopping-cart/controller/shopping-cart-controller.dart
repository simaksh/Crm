import 'package:get/get.dart';

import '../../../../infrastructure/commons/user-type.dart';
import '../models/shopping-cart-choice-product-dto.dart';
import '../models/shopping-cart-choice-product-view-model.dart';
import '../models/shopping-cart-dto.dart';
import '../repository/shopping-cart-repository.dart';

class ShoppingCartPageController extends GetxController {
  final ShoppingCartRepository _repository =
  ShoppingCartRepository();
  RxList<SoppingCartChoiceProductViewModel> selectedProducts = RxList();
  RxBool isGetProductsLoading = false.obs;
  RxBool isGetProductsRetry = false.obs;
  RxBool isDisable = false.obs;
  RxBool isPaymentLoading = false.obs;
  RxInt allTotalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getSelectedProducts();
  }

  Future<void> getSelectedProducts() async {
    isGetProductsLoading.value = true;
    final result =
    await _repository.getSelectedProductsByUserId(userId: UserType.userId!);
    isGetProductsLoading.value = false;
    isGetProductsRetry.value = false;
    result.fold((left) {
      isGetProductsRetry.value = true;
      Get.showSnackbar(GetSnackBar(
        message: '${'error'} : $left',
        duration: const Duration(seconds: 2),
      ));
    }, (right) {
      selectedProducts.addAll(right);
      for (final product in right) {
        allTotalPrice.value =
            allTotalPrice.value + (product.selectedCount * product.price);
      }
    });
  }

  Future<void> increase(int newValue,
      SoppingCartChoiceProductViewModel product, int index) async {
    ShoppingCartChoiceProductDto dto =
    ShoppingCartChoiceProductDto(
      product.image,
      product.description,
      product.colors,
      id: product.id,
      userId: product.userId,
      productId: product.productId,
      tittle: product.tittle,
      price: product.price,
      count: product.count,
      selectedCount: newValue,
    );
    isDisable.value = true;
    final result = await _repository.patchSelectedProduct(dto: dto);
    isDisable.value = false;
    result.fold(
          (left) => Get.showSnackbar(GetSnackBar(
        message: '${'error'} : $left',
        duration: const Duration(seconds: 2),
      )),
          (right) {
        allTotalPrice.value = allTotalPrice.value + product.price;
        selectedProducts[index] =
            SoppingCartChoiceProductViewModel.fromJson(right);
      },
    );
  }

  Future<void> decrease(int newValue,
      SoppingCartChoiceProductViewModel product, int index) async {
    ShoppingCartChoiceProductDto dto =
    ShoppingCartChoiceProductDto(
      product.image,
      product.description,
      product.colors,
      id: product.id,
      userId: product.userId,
      productId: product.productId,
      tittle: product.tittle,
      price: product.price,
      count: product.count,
      selectedCount: newValue,
    );
    isDisable.value = true;
    final result = await _repository.patchSelectedProduct(dto: dto);
    isDisable.value = false;
    result.fold(
            (left) => Get.showSnackbar(GetSnackBar(
          message: '${'error'} : $left',
          duration: const Duration(seconds: 2),
        )), (right) {
      allTotalPrice.value = allTotalPrice.value - product.price;
      selectedProducts[index] =
          SoppingCartChoiceProductViewModel.fromJson(right);
    });
  }

  Future<void> removeButton(
      {required SoppingCartChoiceProductViewModel product}) async {
    isDisable.value = true;
    final result = await _repository.deleteSelectedProduct(id: product.id);
    isDisable.value = false;
    result.fold(
            (left) => Get.showSnackbar(
          GetSnackBar(
            message: '${'error'} : $left',
            duration: const Duration(seconds: 2),
          ),
        ), (right) {
      allTotalPrice.value = 0;
      selectedProducts.clear();
      getSelectedProducts();
    });
  }

  Future<void> paymentButton() async {
    List<ShoppingCartDto> dtoList = [];
    for (final product in selectedProducts) {
      isPaymentLoading.value = true;
      final result1 = await _repository.getProducts(id: product.productId);
      isPaymentLoading.value = false;
      result1.fold(
              (left) => Get.showSnackbar(
            GetSnackBar(
              message: '${'error'} : $left',
              duration: const Duration(seconds: 2),
            ),
          ), (right) async {
        final ShoppingCartDto dto =
        ShoppingCartDto(
          right.image,
          right.description,
          right.colors,
          id: right.id,
          tittle: right.tittle,
          price: right.price,
          count: (right.count - product.selectedCount),
        );
        dtoList.add(dto);
      });
    }
    if (dtoList.length == selectedProducts.length) {
      await patchAndRemoveProduct(dtoList);
    } else {
      await paymentButton();
    }
  }

  Future<void> patchAndRemoveProduct(
      List<ShoppingCartDto> dtoList) async {
    int counter = 0;
    for (final dto in dtoList) {
      isPaymentLoading.value = true;
      final result2 = await _repository.patchProduct(dto: dto);
      isPaymentLoading.value = false;
      result2.fold(
            (left) => Get.showSnackbar(
          GetSnackBar(
            message: '${'error'} : $left',
            duration: const Duration(seconds: 2),
          ),
        ),
            (right) {
          counter++;
        },
      );
    }
    if (counter == selectedProducts.length) {
      counter = 0;
      await deleteSelectProduct(counter);
    } else {
      await patchAndRemoveProduct(dtoList);
    }
  }

  Future<void> deleteSelectProduct(int counter) async {
    for (final product in selectedProducts) {
      isPaymentLoading.value = true;
      final result3 = await _repository.deleteSelectedProduct(id: product.id);
      isPaymentLoading.value = false;
      result3.fold(
              (left) => Get.showSnackbar(
            GetSnackBar(
              message: '${'error'} : $left',
              duration: const Duration(seconds: 2),
            ),
          ),
              (right) => counter++);
    }
    if (counter == selectedProducts.length) {
      selectedProducts.clear();
      Get.back();
    } else {
      await deleteSelectProduct(counter);
    }
  }
}
