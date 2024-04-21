import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker_customer/number_picker_customer.dart';



import '../controller/detail-customer-controller.dart';

class DetailCustomerPageView
    extends GetView<DetailCustomerPageController> {
  const DetailCustomerPageView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text(
        ' Detail Product',
        style: TextStyle(color: Colors.greenAccent),
      ),
    ),
    body: Obx(() {
      return _body();
    }),
  );

  Widget _body() {
    if (controller.isGetProductLoad.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (controller.isGetProductRetry.value) {
      return Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
          onPressed: controller.getProduct,
          child: const Text('retry',style: TextStyle(color: Colors.black),),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Obx(() {
                    return DecoratedBox(
                      decoration: controller.image.value == ''
                          ? BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.greenAccent,
                          )
                        ],
                      )
                          : BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: MemoryImage(
                              base64Decode(controller.image.value)),
                        ),
                      ),
                      child: const SizedBox(
                        height: 250,
                        width: 400,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    return Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        controller.tittle.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    return Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        controller.description.value,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            '${'price'} : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${controller.price.value} \$",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.colors.length,
                          itemBuilder: (context, index) => Icon(
                            Icons.ac_unit,
                            color: Color(
                              int.parse(controller.colors[index],
                                  radix: 16),
                            ),
                          ))),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                    NumberPickerCustomer (
                          initialValue: controller.selectedCount.value,
                          onIncrease: (newValue) =>
                              controller.increase(newValue),
                          onDecrease: (newValue) =>
                              controller.decrease(newValue),
                          minValue: 1,
                          maxValue: controller.count.value,
                        ),
                      ],
                    );
                  }),
                  Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                      onPressed: controller.isAddToShoppingCartLoad.value
                          ? null
                          : controller.addToCartButton,
                      child: controller.isAddToShoppingCartLoad.value
                          ? Transform.scale(
                          scale: 0.75,
                          child: const CircularProgressIndicator())
                          : const Text('Add to cart',style: TextStyle(color: Colors.black),),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
