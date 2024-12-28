import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Const/Host.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import '../../Data/Models/Product.dart';
import 'ToggleFavoriteButton.dart';

class RectangularProductCard extends StatelessWidget {
  final Product product;

  const RectangularProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Get.locale?.languageCode == 'ar';

    return InkWell(
      onTap: () {
        Get.toNamed('/ProductDetails', arguments: product);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 5),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image with Loading Indicator
            SizedBox(
              width: 73.w,
              height: 90.h,
              child: Image.network(
                'http://$host2/images/${product.image}',
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  SizedBox(
                    width: 170.w,
                    child: Text(
                      product.name!,
                      style: AppTextStyles.language.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  // Rating and Reviews
                  Row(
                    children: [
                      Icon(
                        Icons.star_half,
                        color: AppColors.primary,
                        size: 19.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "${product.rate}",
                        style: AppTextStyles.language.copyWith(
                          color: const Color(0xFF8E8EA9),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "review"
                            .trParams({'num': product.totalSold.toString()}),
                        style: AppTextStyles.language.copyWith(
                          color: const Color(0xFFC0C0CF),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  // Price
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${product.price}',
                          style: AppTextStyles.language.copyWith(
                            color: AppColors.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(2, -5),
                            child: Text(
                              '\$',
                              style: AppTextStyles.language.copyWith(
                                color: AppColors.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ToggleFavoriteButton(
                  onChanged: (isFavorite) {
                    // Handle favorite toggle
                  },
                  height: 22.h,
                  width: 22.w,
                ),
                SizedBox(height: 19.h),
                InkWell(
                  onTap: () {
                    // Handle action
                  },
                  child: Container(
                    width: 22.w,
                    height: 22.h,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(isRTL ? 3.1416 : 0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
