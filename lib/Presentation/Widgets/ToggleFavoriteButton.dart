import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Presentation/Controllers/Favorites/FavoritesController.dart';

Widget buildToggleFavoriteButton({
  required double height,
  required double width,
  required Product product,
}) {
  final RxBool isFavorite = product.isFavorite!.obs;

  return Obx(
        () => GestureDetector(
      onTap: () async {
        await Get.find<FavoriteController>().addRemoveFavorite(id: product.id!, product: product);
        isFavorite.value = product.isFavorite!;
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: SvgPicture.asset(
          isFavorite.value
              ? "assets/icons/Like.svg"
              : "assets/icons/Dislike.svg",
          width: width - 5.w,
          height: height - 5.h,
        ),
      ),
    ),
  );
}