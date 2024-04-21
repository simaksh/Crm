import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/src/pages/seller/home/views/range-filter.dart';
import 'package:store/src/pages/seller/home/views/seller-home-list-item.dart';


import '../controller/seller-home-controller.dart';

class SellerHomePage extends GetView<SellerHomePageController> {
  const SellerHomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'SellerPage',
            style: TextStyle(color: Colors.greenAccent),
          ),
        ),
        body: _body(context),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.addButton,
          child: const Icon(
            Icons.add,
            color: Colors.greenAccent,
          ),
        ),

      );


  Widget _body(BuildContext context) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              children: [
                Expanded(
                    child: TextField(
                      controller: controller.searchTextController,
                      onChanged: (value) =>
                          controller.search(value),
                      decoration: const InputDecoration(
                          label: Text(
                            'search...',
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                          fillColor: Colors.greenAccent,
                          counterText: '',
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.greenAccent,
                          ),
                          suffixIcon: Icon(Icons.clear,color: Colors.greenAccent,),

                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(16)))),

                    )),
                Obx(
                      () {
                    if (controller.isGetProductsLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.isGetProductsRetry.value) {
                      return Center(
                        child: ElevatedButton(

                          onPressed: ()=>controller.getProducts(searchText: controller.searchTextController.text), child: const Text('retry'),
                        ),
                      );
                    } else {
                      return controller.products.isEmpty
                          ? const Text(
                        'list is empty',
                        overflow: TextOverflow.ellipsis,
                      )
                          : Expanded(
                        child: ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) => SellerHomeListItem(
                              product: controller.products[index], index: index),
                        ),
                      );
                    }
                  },
                ),

                _language(),
                SizedBox(height: 10,),
                _filter(context),
                ElevatedButton(onPressed: controller.logOutButton,
                    child: const Text(
                      'LogOut', style: TextStyle(color: Colors.greenAccent),))
              ]
          ),

        ),

      );


  Widget _filter(BuildContext context) {
    return IconButton(
        onPressed: () =>
            showDialog(
                context: context,
                builder: (context) =>
                    Obx(() {
                      return AlertDialog(
                        backgroundColor: Colors.greenAccent.shade100,
                        alignment: AlignmentDirectional.topCenter,
                        shadowColor: Colors.greenAccent,
                        title: const Text('filter of color and price'),
                        content: RangeFilter(
                          values: controller.rangeSliderValues.value,
                          min: controller.minPrice.value.toDouble(),
                          max: controller.maxPrice.value.toDouble(),
                          filterColorIndex:
                          controller.filterColorIndex.value,
                          colors: controller.filterColorsList.toList(),
                          onChange: controller.rangePrice,
                          onColorTap: controller.onFilterColorTap,
                          onFilterTap: controller.filterButton,
                          onRemoveFilterTap:
                          controller.removeFilterButton,
                        ),
                      );
                    })),

        icon: const Icon(Icons.filter_list_sharp, color: Colors.greenAccent,));
  }


  Widget _language() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Column(
            children: [
              IconButton(
                onPressed: () =>
                    controller.changeLanguage(
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
                onPressed: () =>
                    controller.changeLanguage(
                      locale: const Locale('fa', 'IR'),
                    ),
                icon: const Icon(
                  Icons.language,
                  color: Colors.greenAccent,
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
      );



}
