import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controller/login-page-controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Login Page',
        style: TextStyle(color: Colors.greenAccent),
      ),
    ),
    body: _body(),
  );

  Widget _body() => Container(
    color: Colors.white54,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLength: 50,
                      controller: controller.userNameTextController,
                      validator: (value) =>
                          controller.usernameAndPassWordFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        counterText: '',
                        label: Text(
                          'userName',
                          overflow: TextOverflow.ellipsis,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                            // رنگ حاشیه در حالت غیرفعال بودن
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                            // رنگ حاشیه در حالت فعال بودن
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
                    child: Obx(() {
                      return TextFormField(
                        controller: controller.passwordTextController,
                        validator: (value) =>
                            controller.usernameAndPassWordFieldValidator(value),
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        obscureText:
                        controller.isPasswordInvisible.value,
                        decoration: InputDecoration(
                          counterText: '',
                          suffixIcon: IconButton(
                            onPressed: controller.showPass,
                            icon: controller.isPasswordInvisible.value
                                ? const Icon(
                              Icons.visibility_off,
                              color: Colors.greenAccent,
                            ) // Show when password is visible
                                : const Icon(
                              Icons.visibility,
                              color: Colors.greenAccent,
                            ), // Show when password is hidden
                          ),
                          label: const Text(
                            'passWord',
                            overflow: TextOverflow.ellipsis,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.greenAccent,
                            value: controller.isRemember.value,
                            onChanged: (value) =>
                                controller.rememberCheck(value)),
                        const Expanded(
                          child: Text(
                            'remember me',
                            style: TextStyle(color: Colors.greenAccent),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent, // Change background color
                      ),
                      child: controller.isLoading.value
                          ? Transform.scale(
                        scale: 0.75,
                        child: const CircularProgressIndicator(),
                      )
                          : const Text(
                        'login',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child:
                  ElevatedButton(
                    onPressed: controller.signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent, // Change background color
                    ),
                    child: const Text(
                      'signup',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () => controller.changeLanguage(
                        locale: const Locale('en', 'US'),
                      ),
                      icon: const Icon(
                        Icons.language,
                        color: Colors.greenAccent, // Change icon color
                      ),
                      tooltip: 'English', // Add a tooltip
                    ),
                    const Text(
                      'English', // Text for English language
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ],
                ),
                const SizedBox(width: 8), // Add spacing between icons
                Column(
                  children: [
                    IconButton(
                      onPressed: () => controller.changeLanguage(
                        locale: const Locale('fa', 'IR'),
                      ),
                      icon: const Icon(
                        Icons.language,
                        color: Colors.greenAccent, // Change icon color
                      ),
                      tooltip: 'فارسی', // Add a tooltip
                    ),
                    const Text(
                      'فارسی', // Text for Persian language
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}