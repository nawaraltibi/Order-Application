import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Const/Host.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/Product.dart';
import 'package:order_application/Presentation/Controllers/Cart/CartController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/ToggleFavoriteButton.dart';
import '../../Widgets/NormalText.dart';
import '../../Widgets/ReviewsContainer.dart';
import '../../Widgets/MinusButton.dart';
import '../../Widgets/PlusButton.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Product product;
  @override
  void initState() {
    super.initState();
    product = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        trailingWidget: buildToggleFavoriteButton(
          height: 36.h,
          width: 36.w, product: product,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        children: [
          Container(
            padding: EdgeInsets.all(26.sp),
            width: 318.w,
            height: 281.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: SizedBox(
              width: 173.w,
              height: 219.h,
              child: Image.network(
                'http://$host2${product.image}',
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
            )
          ),
          SizedBox(
            height: 17.h,
          ),
          Container(
            padding: EdgeInsets.all(18.sp),
            width: 323.w,
            height: 68.h,
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Row(
              children: [
                Text(
                  product.name!,
                  style: AppTextStyles.language.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
                Spacer(),
                ReviewsContainer(
                  rating: product.rate!,
                  reviews: 214,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 23.h,
          ),
          SectionTitle(text: 'Available at:'.tr),
          SizedBox(
            height: 13.h,
          ),
          // MarketCard(
          //     imageType: true,
          //     marketImage: 'assets/images/market.jpg',
          //     marketName: 'XIAOMI',
          //     rating: 4.9,
          //     reviews: 120),
          SizedBox(
            height: 23.h,
          ),
          SectionTitle(text: 'About this item:'.tr),
          SizedBox(
            height: 12.h,
          ),
          NormalText(
            text: product.description,
            size: 14,
          ),
          SizedBox(
            height: 15.h,
          ),
          SectionTitle(text: "Shopping:".tr),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20.w,
              top: 15.h,
              bottom: 15.h,
            ),
            width: 320.w,
            height: 68.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Row(
              children: [
                NormalText(text: "Price:".tr, size: 16),
                SizedBox(
                  width: 10.w,
                ),
                OrangePriceText(price: product.getTotalPrice(), size: 15),
                Spacer(),
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: MinusButton(
                    onTap: () {
                      setState(() {
                        product.decrementQuantity();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  '${product.quantity}',
                  style: AppTextStyles.language.copyWith(
                    color: const Color(0xFF666687),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: PlusButton(
                    onTap: () {
                      setState(() {
                        product.incrementQuantity();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomBlackButton(buttonText: "Add to cart", onPressed: () {
            Get.find<CartController>().addProduct(product);
            Get.back();
          }),
          SizedBox(
            height: 30.h,
          )
        ],
      ),
    );
  }
}