import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../controller/add-seller-page-controller.dart';


class SellerAddProductPage extends GetView<AddSellerPageController> {
  const SellerAddProductPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text(' add product',style: TextStyle(color: Colors.greenAccent),),
        ),
        body: _body(context),

      );

  Widget _body(BuildContext context) => Center(
    child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Obx(
                      () => Stack(
                    children: [
                      DecoratedBox(
                        decoration: controller.imageToString.value == ''
                            ? BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.greenAccent,
                            )
                          ],
                        )
                            : BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                            image: MemoryImage(base64Decode(
                                controller.imageToString.value)),
                          ),
                        ),
                        child: const SizedBox(
                          height: 250,
                          width: 400,
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: IconButton(
                          onPressed: controller.addPicture,
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.white,
                          ),
                          color: Colors.greenAccent,
                        ),
                      ),
                      if (controller.imageToString.value != '')
                        Positioned(
                          right: 1,
                          bottom: 1,
                          child: IconButton(
                            onPressed: controller.removePicture,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 40,
                            ),
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
                      validator: (value) =>
                          controller.TextFormsFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        label: const Text(
                          'title',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(color: Colors.greenAccent),
                        ),
                        fillColor: Colors.greenAccent.withOpacity(0.1),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: controller.descriptionTextController,
                      validator: (value) =>
                          controller.TextFormsFieldValidator(value),
                      maxLines: 5,
                      decoration: InputDecoration(
                        label: const Text(
                          'description',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(color: Colors.greenAccent),
                        ),
                        fillColor: Colors.greenAccent.withOpacity(0.1),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.priceTextController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) =>
                          controller.TextFormsFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        label: const Text(
                          'price',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(color: Colors.greenAccent),
                        ),
                        fillColor: Colors.greenAccent.withOpacity(0.1),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.countTextController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) => controller.TextFormsFieldValidator(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        label: const Text(
                          'count',
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(color: Colors.greenAccent),
                        ),
                        fillColor: Colors.greenAccent.withOpacity(0.1),
                        filled: true,
                      ),
                    ),
                  ) ,
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
                            'colors',
                            style: TextStyle(overflow: TextOverflow.ellipsis,color: Colors.greenAccent),
                          )),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor:
                                Colors.greenAccent.shade100,
                                title: const Text(
                                  'select color',
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor:
                                    controller.pickedColor.value,
                                    onColorChanged: (color) =>
                                        controller.updateColor(color),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('ok'),
                                    onPressed: () {
                                      controller.colorPicker();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                        },
                        icon: const Icon(
                          Icons.color_lens_outlined,
                          color: Colors.greenAccent,
                          size: 70,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                        () => SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.colors.length,
                        itemBuilder: (context, index) => Stack(children: [
                          Icon(Icons.ac_unit,
                              size:70,
                              color: Color(
                                int.parse(controller.colors[index], radix: 16),
                              )),
                          Positioned(
                            child: IconButton(

                              onPressed: () => controller.removeColor(index),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                  ,
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                onPressed: controller.isLoading.value
                    ? null
                    : controller.submitButton,
                child: controller.isLoading.value
                    ? Transform.scale(
                    scale:0.5, child: const CircularProgressIndicator())
                    : const Text('submit',style: TextStyle(color: Colors.black),))
          ]),
        )),
  );
}