import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/BlackPriceText.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomOrangeButton.dart';
import 'package:order_application/Presentation/Widgets/OrangePriceText.dart';
import 'package:order_application/Presentation/Widgets/ProductCardForCart.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';
import '../../Widgets/PlaceOrCardText.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // This changes when I press on the arrow in the location container
  bool _isExpanded = false;

  // I get this from PlaceOrCardText Widget, if it is true it will show the location in the container
  bool _isThereLocation = false;

  // Same thing for the card
  bool _isThereCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Cart'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: Get.locale?.languageCode == 'ar' ? 210.w : -17.w,
                      top: -15.h,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(
                            Get.locale?.languageCode == 'ar' ? 3.1416 : 0),
                        child: SvgPicture.asset(
                          'assets/images/two-white-circles.svg',
                          width: 141.w,
                          height: 145.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'attention'.tr,
                            style: AppTextStyles.language.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFA5A5BA),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Confirm or cancel your cart before\nexiting the application.'
                                .tr,
                            style: AppTextStyles.language.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SectionTitle(text: 'What has been determined:'.tr),
              SizedBox(
                height: 15.h,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: SwipeToDeleteWidget(
                        height: 120,
                        child: ProductCardForCart(
                          imageType: true,
                          productImage: 'assets/images/mobile.jpg',
                          productName: 'Samsung Galaxy A35',
                          rating: 4.9,
                          reviews: 120,
                          price: 1700,
                        ),
                        onSwipe: () {}),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Delivery address'.tr,
                          style: AppTextStyles.language.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8E8EA9),
                          ),
                        ),
                        Spacer(),
                        _isExpanded
                            ? IconButton(
                            onPressed: () {
                              setState(() {
                                _isExpanded = false;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.primary,
                              size: 23.sp,
                            ))
                            : IconButton(
                            onPressed: () {
                              setState(() {
                                _isExpanded = true;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.primary,
                              size: 23.sp,
                            ))
                      ],
                    ),
                    _isExpanded
                        ? _isThereLocation
                        ? Column(
                      children: [
                        Container(
                          margin:
                          EdgeInsets.only(top: 10.h, bottom: 5.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 20.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F1F1F1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Home',
                                style: AppTextStyles.language
                                    .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF263238)),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'Kafr Sousa',
                                style: AppTextStyles.language
                                    .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF8E8EA9)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'Abdullah Ibn Rawaha Street',
                                style: AppTextStyles.language
                                    .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF8E8EA9)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: 10.w, top: 15.h),
                          child: PlaceOrCardText(
                            isAdd: false,
                            isPlace: true,
                            isThereLocation: (val) {
                              setState(() {
                                _isThereLocation = val;
                              });
                            },
                            isThereCard: (val) {},
                          ),
                        )
                      ],
                    )
                        : Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: PlaceOrCardText(
                        isPlace: true,
                        isAdd: true,
                        isThereLocation: (val) {
                          setState(() {
                            _isThereLocation = val;
                          });
                        },
                        isThereCard: (val) {},
                      ),
                    )
                        : Container()
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Price of products'.tr,
                          style: AppTextStyles.language.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF666687),
                          ),
                        ),
                        Spacer(),
                        BlackPriceText(price: 8300, size: 14),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Delivery'.tr,
                          style: AppTextStyles.language.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF666687),
                          ),
                        ),
                        Spacer(),
                        BlackPriceText(price: 1000, size: 14),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Divider(
                        thickness: 1.5,
                        color: Color(0xFFEAEAEF),
                      ),
                    ),
                    _isThereCard
                        ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 10.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Color(0xFFEAEAEF),
                                width: 1,
                              )),
                          child: ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/Credit-Card.svg',
                              width: 24.w,
                              height: 24.h,
                            ),
                            title: Text(
                              'Nawar Al-Tibi',
                              style: AppTextStyles.language.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8E8EA9)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 25.w),
                          child: PlaceOrCardText(
                              isAdd: false,
                              isPlace: false,
                              isThereLocation: (val) {},
                              isThereCard: (val) {
                                setState(() {
                                  _isThereCard = val;
                                });
                              }),
                        )
                      ],
                    )
                        : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 25.w),
                      child: PlaceOrCardText(
                          isAdd: true,
                          isPlace: false,
                          isThereLocation: (val) {},
                          isThereCard: (val) {
                            setState(() {
                              _isThereCard = val;
                            });
                          }),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Color(0xFFEAEAEF),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Row(
                        children: [
                          Text(
                            'Total price'.tr,
                            style: AppTextStyles.language.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4A4A6A)),
                          ),
                          Spacer(),
                          OrangePriceText(price: 9300, size: 16)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomBlackButton(buttonText: 'Buy'.tr, onPressed: () {}),
              SizedBox(
                height: 20.h,
              ),
              CustomOrangebButton(buttonText: 'Cancel'.tr, onPressed: () {}),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
