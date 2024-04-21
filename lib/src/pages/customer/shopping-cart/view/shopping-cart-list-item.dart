import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:number_picker_customer/number_picker_customer.dart';
import '../controller/shopping-cart-controller.dart';
import '../models/shopping-cart-choice-product-view-model.dart';


class ShoppingCartListItem
    extends GetView<ShoppingCartPageController> {
  final SoppingCartChoiceProductViewModel product;
  final int index;

  const ShoppingCartListItem(
      {required this.product, required this.index, super.key});

  @override
  Widget build(BuildContext context) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Card(
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                      product.tittle,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                IconButton(
                                  onPressed: () =>
                                  controller.isDisable.value
                                      ? null
                                      : controller.removeButton(product: product),
                                  icon: const Icon(Icons.delete,color: Colors.red,),
                                ),
                              ],
                            ) ,
                            const SizedBox(height: 10,),
                            Obx(
                                  () {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
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
                                              '${product.selectedCount * product.price} \$',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    NumberPickerCustomer(

                                      initialValue: product.selectedCount,
                                      onIncrease: (newValue) =>
                                          controller.increase(newValue, product, index),
                                      onDecrease: (newValue) =>
                                          controller.decrease(newValue, product, index),
                                      minValue: 1,
                                      maxValue: product.count,
                                    )
                                    ,
                                  ],
                                );
                              },
                            )
                          ]
                      )
                  )
              )
          )
      );
}
