import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Data/Models/EmptyState.dart';
import 'package:order_application/Data/Models/SearchType.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/EmptyStateWidget.dart';
import 'package:order_application/Presentation/Widgets/FavoritesButton.dart';
import 'package:order_application/Presentation/Widgets/FilterWidget.dart';
import 'package:order_application/Presentation/Widgets/MarketCard.dart';
import 'package:order_application/Presentation/Widgets/RectangularProductCard.dart';
import 'package:order_application/Presentation/Widgets/SearchField.dart';
import 'package:order_application/Presentation/Controllers/Search/SearchFieldController.dart';

class SearchScreen extends GetView<SearchFieldController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Search'.tr,
        controller: Get.find<DashboardController>(),
        trailingWidget: FavoritesButton(),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
        child: Column(
          children: [
            SearchField(
              onSearchChanged: (searchQuery) {
                controller.onSearchChanged(searchQuery);
              },
            ),
            SizedBox(height: 25.h),
            FilterWidget(
              filters: const [SearchType.products, SearchType.markets],
              onFilterChanged: (selectedFilter) {
                controller.onFilterChanged(selectedFilter);
              },
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: Obx(() {
                final selectedFilter = controller.selectedFilter.value;
                final isProducts = selectedFilter == SearchType.products;

                if (controller.loadingMap['searchProducts']!.value &&
                    controller.products.isEmpty &&
                    controller.markets.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchQuery.isEmpty) {
                  return const SingleChildScrollView(child: Center(
                      child: EmptyStateWidget(state: EmptyState.searchPrompt)),);
                }

                if ((isProducts && controller.products.isEmpty) ||
                    (!isProducts && controller.markets.isEmpty)) {
                  return const Center(
                      child: EmptyStateWidget(state: EmptyState.noResults));
                }

                final list =
                    isProducts ? controller.products : controller.markets;

                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        !(controller.loadingMap['searchProducts']?.value ??
                            false)) {
                      controller.getNextSearchPage();
                    }
                    return true;
                  },
                  child: ListView.separated(
                    itemCount: list.length + 1,
                    separatorBuilder: (_, __) => SizedBox(height: 20.h),
                    itemBuilder: (context, index) {
                      if (index == list.length) {
                        return Obx(() {
                          if (controller.meta.value?.currentPage ==
                                  controller.meta.value?.lastPage ||
                              !(controller
                                      .loadingMap['searchProducts']?.value ??
                                  false)) {
                            return SizedBox.shrink();
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        });
                      }

                      if (isProducts) {
                        final product = controller.products[index];
                        return RectangularProductCard(
                          product: product,
                        );
                      } else {
                        final market = controller.markets[index];
                        return MarketCard(
                          market: market,
                        );
                      }
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
