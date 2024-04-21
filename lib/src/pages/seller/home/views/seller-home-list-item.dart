import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/seller-home-controller.dart';
import '../models/seller-home-view-model.dart';

class SellerHomeListItem extends GetView<SellerHomePageController> {
  final SellerHomeViewModel product;
  final int index;

  const SellerHomeListItem(
      {required this.product, required this.index, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        DecoratedBox(
            decoration: product.image == ''
                ? BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            )
                : BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: MemoryImage(base64Decode(product.image!)),
                ))),Row(
          children: [
            const Text('active'),
            Transform.scale(scale: 0.5,child: Switch(value:product.isActive, onChanged: ( value)=>controller.isActiveDisable.value?null:controller.SwichButton(value, product),

            ),)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                    product.tittle,
                    style: const TextStyle(color: Colors.black),
                  )),
              IconButton(
                  onPressed: () => controller.edit(product.id),
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.orange,
                  ))
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                      product.description,
                      style: const TextStyle(color: Colors.black),
                    )),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'price',
                        style: TextStyle(color: Colors.black),
                      ),
                      Expanded(child: Text('${product.price} \$'))
                    ],
                  )),
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'count',
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        product.count.toString(),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            itemBuilder: (context, index) => const Icon(
              Icons.ac_unit,
              color: Colors.greenAccent,
            ),
            itemCount: product.colors.length,
          ),
        )
      ],
    ),
  );
}
