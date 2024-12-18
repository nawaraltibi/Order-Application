import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/FavoritesButton.dart';
import 'package:order_application/Presentation/Widgets/FilterWidget.dart';
import 'package:order_application/Presentation/Widgets/MarketCard.dart';
import 'package:order_application/Presentation/Widgets/ProductCard.dart';
import 'package:order_application/Presentation/Widgets/SearchField.dart';

class SearchScreen extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search'.tr,controller:Get.find<DashboardController>(),trailingWidget: FavoritesButton(),),
      body: Container(
          padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
          child: Column(
            children: [
              SearchField(
                onSearchChanged: (String){},
                onSortSelected: (String){},
              ),
              SizedBox(height: 25.h,),
              FilterWidget(filters: ['all'.tr, 'markets'.tr, 'products'.tr]),
              SizedBox(height: 25.h,),
              ProductCard(imageType: true, productImage: 'assets/images/mobile.jpg', productName: 'Samsung Galaxy A35', rating: 4.9, reviews: 120, price: 1700,),
              SizedBox(height: 25.h,),
              MarketCard(imageType: true, marketImage: 'assets/images/market.jpg', marketName: 'xiaomi', rating: 2.3, reviews: 234,),
            ],
          )
      ),
    );
  }
}
