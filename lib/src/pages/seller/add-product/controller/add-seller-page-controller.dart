import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../infrastructure/commons/user-type.dart';
import '../models/seller-add-product-dto.dart';
import '../repository/add-repository.dart';


class AddSellerPageController extends GetxController {
  final  SellerAddRepository _sellerAddRepository = SellerAddRepository();
  final TextEditingController tittleTextController = TextEditingController(),
      descriptionTextController = TextEditingController(),
      priceTextController = TextEditingController(),
      countTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  Rx<String> imageToString = "".obs;
  Rx<Color> pickedColor = const Color(0xff04927c).obs;
  RxList<String> colors = RxList();
  RxBool isLoading = false.obs;

  Future<void> addPicture() async {
    final picker = ImagePicker();
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      List<int> imageBytes = await imagePicked.readAsBytes();
      imageToString.value = base64Encode(imageBytes);
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'image isnt select',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void removePicture() {
    imageToString.value = '';
  }

  void updateColor(Color color) {
    pickedColor.value = color;
  }

  void removeColor(int index) {
    colors.removeAt(index);
  }

  String? TextFormsFieldValidator(value) {
    return value == null || value.isEmpty ? 'required' : null;
  }

  Future<void> submitButton() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    isLoading.value = true;
    final result =
    await _sellerAddRepository.getProductByTittle(tittle: tittleTextController.text);
    isLoading.value = false;
    result.fold(
          (left) {
        Get.showSnackbar(
          GetSnackBar(
            message: '${'error'} : $left',
            duration: const Duration(seconds: 2),
          ),
        );
      },
          (right) async {
        if (right.isEmpty) {
          isLoading.value = true;
          final result = await _sellerAddRepository.postProduct(

            dto: SellerAddProductDto(
              descriptionTextController.text,
              imageToString.value,
              colors,
              tittle: tittleTextController.text,
              count: int.parse(countTextController.text.trim()),
              price: int.parse(priceTextController.text.trim()),
              sellerId: UserType.userId!,
            ),
          );
          isLoading.value = false;
          result.fold(
                (left) {
              Get.showSnackbar(GetSnackBar(
                message: '${'error'} : $left',
                duration: const Duration(seconds: 2),
              ));
            },
                (right) => Get.back(result: right),
          );
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              message: 'exit',
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }

  void colorPicker() {
    colors.add(pickedColor.value.toString().split('(0x')[1].split(')')[0]);
  }
}
