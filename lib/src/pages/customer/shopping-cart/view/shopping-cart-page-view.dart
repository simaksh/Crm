import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/src/pages/customer/shopping-cart/view/shopping-cart-list-item.dart';


import '../controller/shopping-cart-controller.dart';


class ShoppingCartPageView extends GetView<ShoppingCartPageController> {
  const ShoppingCartPageView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor:Colors.greenAccent.shade100,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: const Text('Shopping Cart', style: TextStyle(color: Colors.greenAccent)),
    ),
    body: _body(),
  );

  Obx _body() {
    return Obx(
          () {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                controller.isGetProductsLoading.value
                    ? const Center(
                  child: LinearProgressIndicator(),
                )
                    : controller.isGetProductsRetry.value
                    ? Center(
                  child: ElevatedButton(
                    onPressed: controller.getSelectedProducts,
                    child: const Text('Retry'),
                  ),
                )
                    : controller.selectedProducts.isEmpty
                    ? const Text(
                  'Empty list',
                  overflow: TextOverflow.ellipsis,
                )
                    : Center(
                  child: ListView.builder(
                    itemCount: controller.selectedProducts.length,
                    itemBuilder: (context, index) =>
                        ShoppingCartListItem(
                          product: controller.selectedProducts[index],
                          index: index,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total price=',
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${controller.allTotalPrice.value} \$',
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 500),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                  onPressed: controller.selectedProducts.isEmpty || controller.isPaymentLoading.value
                      ? null
                      : controller.paymentButton,
                  child: controller.isPaymentLoading.value
                      ? Transform.scale(
                    scale: 0.75,
                    child: const CircularProgressIndicator(),

                  )
                      : const Text('Payment',style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}