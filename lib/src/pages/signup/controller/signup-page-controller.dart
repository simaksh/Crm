import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../models/signup-dto.dart';
import '../repository/signup-repository.dart';

class SignupPageController extends GetxController {
  final SignupRepository _repository = SignupRepository();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController firstNameTextController = TextEditingController(),
      lastNameTextController = TextEditingController(),
      userNameTextController = TextEditingController(),
      passwordTextController = TextEditingController(),
      repeatPasswordTextController = TextEditingController();
  RxBool isAdmin = false.obs;
  RxBool isLoading = false.obs;

  void radioButton(newValue) {
    isAdmin.value = newValue;
  }

  String? TextFormsFieldValidator(value) {
    return value == null || value.trim().isEmpty
        ? 'required'
        : value != passwordTextController.text
        ? 'wrong'
        : null;
  }

  String? passwordFieldValidator(value) {
    return value == null || value.trim().isEmpty
        ? 'required'
        : value.trim().length < 5
        ? 'required'
        : null;
  }


  Future<void> signUp() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    isLoading.value = true;
    final result = await _repository.getUserByUserName(
        userName: userNameTextController.text.trim());
    isLoading.value = false;
    result.fold((left) {
      return Get.showSnackbar(
        GetSnackBar(
          message: '${'error'} : $left',
          duration: const Duration(seconds: 2),
        ),
      );
    }, (right) async {
      if (right.isEmpty) {
        isLoading.value = true;
        final result = await _repository.postUser(
          dto: SignupDto(
            firstName: firstNameTextController.text.trim(),
            lastName: lastNameTextController.text.trim(),
            userName: userNameTextController.text.trim(),
            password: passwordTextController.text.trim(),
            isAdmin: isAdmin.value,
          ),
        );
        isLoading.value = false;
        result.fold(
                (left) => Get.showSnackbar(
              GetSnackBar(
                message: '${'error'} : $left',
                duration: const Duration(seconds: 2),
              ),
            ), (right) {
          Get.back(result: {
            'userName': right['userName'],
            'password': right['password']
          });
        });
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            message:'userName exit',
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }
}
