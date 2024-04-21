import 'package:get/get.dart';


import '../../../../infrastructure/commons/user-type.dart';
import '../model/detail-customer-choiceview-model.dart';
import '../model/detail-customer-patch-dto.dart';
import '../model/detail-customer-post-dto.dart';

import '../repository/detail-customer-repository.dart';

class DetailCustomerPageController extends GetxController {
  final int productId;

  DetailCustomerPageController({required this.productId});

  final DetailCustomerRepository _repository =
  DetailCustomerRepository();
  RxString image = ''.obs;
  RxString tittle = ''.obs;
  RxString description = ''.obs;
  RxInt price = RxInt(0);
  RxInt count = RxInt(0);
  RxInt id = RxInt(0);
  RxList<String> colors = RxList();
  RxBool isGetProductLoad = false.obs;
  RxBool isGetProductRetry = false.obs;
  RxBool isAddToShoppingCartLoad = false.obs;
  RxInt selectedCount = 1.obs;
  int changeCount = 0;
  bool isExistInSelectedProducts = false;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  Future<void> getProduct() async {
    isExistInSelectedProducts = false;
    isGetProductRetry.value = false;
    isGetProductLoad.value = true;
    final result = await _repository.getSelectedProductByProductIdAndUserId(
      userId: UserType.userId!,
      productId: productId,
    );
    isGetProductLoad.value = false;
    result.fold(
          (left) {
        isGetProductRetry.value = true;
        Get.showSnackbar(
          GetSnackBar(
            message: '${'error'} : $left',
            duration: const Duration(seconds: 2),
          ),
        );
      },
          (right) async {
        if (right.isNotEmpty) {
          DetailCustomerChoiceViewModel product =
          DetailCustomerChoiceViewModel.fromJson(right[0]);
          isExistInSelectedProducts = true;
          id.value = product.id;
          image.value = product.image ?? '';
          tittle.value = product.tittle;
          description.value = product.description ?? '';
          price.value = product.price;
          count.value = product.count;
          colors.addAll(product.colors);
          selectedCount.value = product.selectedCount;
          changeCount = product.selectedCount;
        } else {
          isGetProductRetry.value = false;
          isGetProductLoad.value = true;
          final result = await _repository.getProductById(id: productId);
          isGetProductLoad.value = false;
          result.fold(
                (left) {
              isGetProductRetry.value = true;
              Get.showSnackbar(
                GetSnackBar(
                  message: '${'error'} : $left',
                  duration: const Duration(seconds: 2),
                ),
              );
            },
                (right) {
              image.value = right.image ?? '';
              tittle.value = right.tittle;
              description.value = right.description ?? '';
              price.value = right.price;
              count.value = right.count;
              colors.addAll(right.colors.cast<String>());
            },
          );
        }
      },
    );
  }

  void increase(int newValue) {
    selectedCount.value = newValue;
  }

  void decrease(int newValue) {
    selectedCount.value = newValue;
  }

  Future<void> addToCartButton() async {
    if (isExistInSelectedProducts) {
      final DetailCustomerPathDto dto =
      DetailCustomerPathDto(
        image.value,
        description.value,
        colors,
        id: id.value,
        userId: UserType.userId!,
        productId: productId,
        tittle: tittle.value,
        price: price.value,
        count: count.value,
        selectedCount: selectedCount.value,
      );
      isAddToShoppingCartLoad.value = true;
      final result = await _repository.patchSelectedProduct(dto: dto);
      isAddToShoppingCartLoad.value = false;
      result.fold((left) {
        Get.showSnackbar(GetSnackBar(
          message: '${'error'} : $left',
          duration: const Duration(seconds: 2),
        ));
      }, (right) {
        changeCount = selectedCount.value - changeCount;
        Get.back(result: changeCount);
      });
    } else {
      final DetailCustomerPostDto dto =
      DetailCustomerPostDto(
        image.value,
        description.value,
        colors,
        userId: UserType.userId!,
        productId: productId,
        tittle: tittle.value,
        price: price.value,
        count: count.value,
        selectedCount: selectedCount.value,
      );
      isAddToShoppingCartLoad.value = true;
      final result = await _repository.postSelectedProduct(dto: dto);
      isAddToShoppingCartLoad.value = false;
      result.fold((left) {
        Get.showSnackbar(GetSnackBar(
          message: '${'error'} : $left',
          duration: const Duration(seconds: 2),
        ));
      }, (right) {
        changeCount = selectedCount.value - changeCount;
        Get.back(result: changeCount);
      });
    }
  }
}
