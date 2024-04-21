import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/signup-page-controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  const SignupPageView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('SignUp'),
    ),
    body: _body(),
  );

  Widget _body() => SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.firstNameTextController,
                      validator: (value) => controller.TextFormsFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(

                        label: Text(
                          'firstName',style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      controller: controller.lastNameTextController,
                      validator: (value) => controller.TextFormsFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(

                        label: Text(
                          'lastName',style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      controller: controller.userNameTextController,
                      validator: (value) => controller.TextFormsFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(

                        label: Text(
                          'userName',style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      controller: controller.passwordTextController,
                      validator: (value) => controller.passwordFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(

                        label: Text(
                          'passWord',style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(

                      controller: controller.repeatPasswordTextController,
                      validator: (value) => controller.TextFormsFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(

                        label: Text(
                          'repeatPassWord',style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
                  () => Column(
                children: [
                  RadioListTile(
                    activeColor: Colors.greenAccent,
                    title: const Text(
                      'seller',
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: true,
                    groupValue: controller.isAdmin.value,
                    onChanged: (value) => controller.radioButton(value),
                  ),
                  RadioListTile(
                    activeColor: Colors.greenAccent,
                    title: const Text(
                      'customer',
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: false,
                    groupValue: controller.isAdmin.value,
                    onChanged: (value) => controller.radioButton(value),
                  ),
                ],
              ),
            ),
            Obx(
                  () {
                return ElevatedButton(
                  onPressed: controller.signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Change background color
                  ),
                  child: controller.isLoading.value
                      ? Transform.scale(
                    scale: 0.5,
                    child: const CircularProgressIndicator(),
                  )
                      : const Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}