import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../controller/seller-edit-controller.dart';

class SellerEditPage extends GetView<SellerEditPageController> {
  const SellerEditPage({super.key,});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Edit Product',
        style: TextStyle(color: Colors.greenAccent),
      ),
    ),
    body: Obx(() => _body(context)),
  );

  Widget _body(BuildContext context) {
    if (controller.isGetProductLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (controller.isGetProductRetry.value) {
        return Center(
          child: ElevatedButton(
            onPressed: controller.getProduct,
            child: const Text(
              'retry',
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
        );
      } else {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Obx(
                            () => Stack(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.greenAccent,
                                  )
                                ],
                              ),
                              child: controller.image.value == ''
                                  ? const SizedBox(
                                height: 250,
                                width: 400,
                              )
                                  : SizedBox(
                                height: 250,
                                width: 400,
                                child: Image.memory(
                                  base64Decode(controller.image.value),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: IconButton(
                                onPressed: controller.onAddImagePressed,
                                icon: const Icon(Icons.camera_alt),
                                color: Colors.white,
                              ),
                            ),
                            if (controller.image.value != '')
                              Positioned(
                                bottom: 1,
                                right: 1,
                                child: IconButton(
                                  onPressed: controller.onDeleteImagePressed,
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: controller.tittleTextController,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (value) => controller.TextFormsFieldValidator(value),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.greenAccent.withOpacity(0.1),
                              labelStyle: TextStyle(color: Colors.greenAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.greenAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.greenAccent),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 1000,
                            controller: controller.descriptionTextController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: 'description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: Colors.greenAccent.withOpacity(0.1),
                              labelStyle: TextStyle(color: Colors.greenAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.greenAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.greenAccent),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 10,
                            controller: controller.priceTextController,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (value) => controller.TextFormsFieldValidator(value),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: Colors.greenAccent.withOpacity(0.1),
                              labelStyle: const TextStyle(color: Colors.greenAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: Colors.greenAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: Colors.greenAccent),
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'color',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: Colors.greenAccent.shade100,
                                    title: const Text(
                                      'select color',
                                    ),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: controller.pickedColor.value,
                                        onColorChanged: (color) => controller.onColorChange(color),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('ok'),
                                        onPressed: () {
                                          controller.onColorPickersOkPressed();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.color_lens_outlined,color: Colors.greenAccent,size: 70,),
                            ),
                          ],
                        ),
                        Obx(
                              () => SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.colors.length,
                              itemBuilder: (context, index) => Stack(
                                children: [
                                  Icon(
                                    Icons.ac_unit,
                                    color: Color(int.parse(controller.colors[index], radix: 16)),
                                  ),
                                  Positioned(
                                    left: 10,
                                    bottom: 30,
                                    child: InkWell(
                                      onTap: () => controller.onColorRemoveTap(index),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                    onPressed: controller.isEditLoading.value ? null : controller.onEditPressed,
                    child: controller.isEditLoading.value
                        ? Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(),
                    )
                        : const Text('Edit',style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
  }
}