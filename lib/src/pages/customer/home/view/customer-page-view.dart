import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/customer-page-controller.dart';
import 'customer-list-item.dart';

class CustomerHomePage extends GetView<CustomerHomePageController> {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Product List',
        style: TextStyle(color: Colors.greenAccent),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: controller.shoppingCartButton,
              icon: const Icon(Icons.shopping_cart_outlined,color: Colors.red,size: 20,),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Obx(
                    () => Text(
                  controller.allProductsSelectedCount.value != 0
                      ? controller.allProductsSelectedCount.value.toString()
                      : '',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: controller.logOutButton,
              child: const Text(
                'LogOut',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () => controller.changeLanguage(
                locale: const Locale('en', 'US'),
              ),
              icon: const Icon(
                Icons.language,
                color: Colors.greenAccent,
              ),
              tooltip: 'English',
            ),
            const Text(
              'English', // Text for English language
              style: TextStyle(color: Colors.greenAccent),
            ),
            IconButton(
              onPressed: () => controller.changeLanguage(
                locale: const Locale('fa', 'IR'),
              ),
              icon: const Icon(
                Icons.language,
                color: Colors.greenAccent,
              ),
              tooltip: 'فارسی',
            ),
            const Text(
              'فارسی', // Text for Persian language
              style: TextStyle(color: Colors.greenAccent),
            ),
          ],
        )
      ],
    ),
    body: _body(context),
  );

  Widget _body(BuildContext context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchTextController,
                    onChanged: (value) => controller.search(value),
                    decoration: const InputDecoration(
                      labelText: 'search...',
                      labelStyle: TextStyle(color: Colors.greenAccent),
                      fillColor: Colors.greenAccent,
                      counterText: '',
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.greenAccent,
                      ),
                      suffixIcon: Icon(Icons.clear, color: Colors.greenAccent),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
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
                          color: Colors.green,
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
            const SizedBox(height: 10),
            Obx(
                  () => controller.isGetProductsLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.isGetProductsRetry.value
                  ? Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                  onPressed: () => controller.getProducts(
                      searchText: controller.searchTextController.text),
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
                  : controller.products.isEmpty
                  ? const Text(
                'Empty',
                style: TextStyle(color: Colors.greenAccent),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) => CustomerHomeListItem(
                      product: controller.products[index], index: index),
                ),
              ),
            )]));
}