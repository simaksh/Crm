import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/customer-page-controller.dart';

import '../models/customer-product-view-model.dart';


class CustomerHomeListItem extends GetView<CustomerHomePageController> {
  final CustomerProductViewModel product;
  final int index;

  const CustomerHomeListItem(
      {required this.product, required this.index, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: InkWell(
      onTap: () => controller.productButton(product.id),
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: product.image == ''
                      ? BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                      )
                    ],
                  )
                      : BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(product.image!)),
                    ),
                  ),
                  child: const SizedBox(
                    height: 250,
                    width: 400,
                  ),
                ) ,
                const SizedBox(height: 8,),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    product.tittle,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(height: 8,),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    product.description ?? '',
                    maxLines: 4,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(height: 8,),
                Row(
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
                              '${product.price} \$',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              textAlign: TextAlign.end,
                              '${'count'} : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.end,
                              product.count.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                ,
                SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.colors.length,
                        itemBuilder: (context, index) => Icon(
                          Icons.circle,
                          color: Color(
                            int.parse(product.colors[index], radix: 16),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    ),
  );


}
