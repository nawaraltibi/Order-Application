import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Data/Models/EmptyState.dart';
import 'EmptyStateWidget.dart';
import 'SquareProductCard.dart';

Widget buildHorizontalList({
  required bool isLoading,
  required String? hasError,
  required RxList items,
  required VoidCallback onRetry,
}) {
  if (isLoading) {
    return Center(child: CircularProgressIndicator());
  } else if (hasError != null) {
    return const Center(
      child: EmptyStateWidget(
        state: EmptyState.noResults,
      ),
    );
  } else {
    return SizedBox(
      height: 190.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final product = items[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: SquareProductCard(
                product: product,
              ),
            ),
          );
        },
      ),
    );
  }
}