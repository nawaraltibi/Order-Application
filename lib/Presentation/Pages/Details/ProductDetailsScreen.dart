import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/MarketCard.dart';
import 'package:order_application/Presentation/Widgets/PriceText.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/ToggleFavoriteButton.dart';

import '../../Widgets/NormalText.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int numberOfProducts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        trailingWidget: ToggleFavoriteButton(onChanged: (val) {}, height: 36.h, width: 36.w,),
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
            child: Image.asset(
              "assets/images/mobile.jpg",
              width: 173.w,
              height: 219.h,
              fit: BoxFit.contain,
            ),
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
                  "Samsung Galaxy A35",
                  style: AppTextStyles.language.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  width: 40.w,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 75.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.primary,
                        size: 15,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        '5.0(214)',
                        style: AppTextStyles.language.copyWith(
                            fontSize: 12.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 23.h,
          ),
          const SectionTitle(text: 'Available at:'),
          SizedBox(
            height: 13.h,
          ),
          MarketCard(
              imageType: true,
              marketImage: 'assets/images/market.jpg',
              marketName: 'XIAOMI',
              rating: 4.9,
              reviews: 120),
          SizedBox(
            height: 23.h,
          ),
          const SectionTitle(text: 'About this item:'),
          SizedBox(
            height: 12.h,
          ),
          const NormalText(
            text: """
\u2022 64 MP Mobile Telephoto Camera; 12 MP Mobile Front Camera; 12 MP Mobile Wide Camera; The power to take your best smartphone shots yet
\u2022 120 Hz smartphone with 6.2 Inch Dynamic AMOLED 2X display: keeps everything looking brilliant & smooth
\u2022 Galaxy S21 mobile phone battery packs in 4,000 mAh so you can stay in charge throughout the day
\u2022 Exynos 2100 5nm smartphone processor brings all the performance you need. Packed with the oomph to rule your social feed while effortlessly keeping up with 8K video editing
\u2022 Featuring the toughest Gorilla Glass Victus, Glastic Rear & an AL7s10 Metal Frame for mobile phone protection & peace of mind
\u2022 Smartphone preloaded with the Android mobile phone V10 operating system           """,
            size: 14,
          ),
          SizedBox(
            height: 15.h,
          ),
          const SectionTitle(text: "Shopping:"),
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
                const NormalText(text: "Price:", size: 16),
                SizedBox(
                  width: 10.w,
                ),
                const PriceText(price: 200, size: 15),
                SizedBox(
                  width: 70.w,
                ),
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (numberOfProducts > 0) numberOfProducts--;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        backgroundColor: const Color(0xFFEAEAEF),
                        elevation: 0,
                        padding: EdgeInsets.only(
                            right: 0, left: 0, bottom: 15.h, top: 0)),
                    child: Icon(
                      Icons.minimize_rounded,
                      color: const Color(0xFF292D32),
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  '$numberOfProducts',
                  style: AppTextStyles.language.copyWith(
                      color: const Color(0xFF666687),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  width: 12.w,
                ),
                SizedBox(
                  width: 32.w,
                  height: 32.h,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        numberOfProducts++;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.orangeAccent,
                        backgroundColor: Colors.orange[100],
                        elevation: 0,
                        padding: EdgeInsets.only(
                            right: 0, left: 0, bottom: 12.h, top: 5.h)),
                    child: Icon(
                      Icons.add,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomBlackButton(buttonText: "Add to cart", onPressed: (){}),
          SizedBox(height: 30.h,)
        ],
      ),
    );
  }
}
