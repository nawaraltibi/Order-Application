import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import 'CustomBlackButton.dart';
import 'SectionTitle.dart';

class PlaceOrCardText extends StatefulWidget {
  // This is to know is it for location or for card
  final bool isPlace;
  // This is to know if it to add or change
  final bool isAdd;
  // This return true when I press on a location to show it in the cart page
  final ValueChanged<bool> isThereLocation;
  // Same thing but to the card
  final ValueChanged<bool> isThereCard;
  PlaceOrCardText({
    required this.isAdd,
    required this.isPlace,
    required this.isThereLocation,
    required this.isThereCard,
    super.key,
  });

  @override
  State<PlaceOrCardText> createState() => _PlaceOrCardTextState();
}

class _PlaceOrCardTextState extends State<PlaceOrCardText> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
              ),
              backgroundColor: Colors.white,
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                        text: widget.isPlace
                            ? 'Available locations:'.tr
                            : 'Available cards:'.tr),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 260.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(14.r),
                                onTap: () {
                                  if(widget.isPlace){
                                    widget.isThereLocation(true);
                                  }else{
                                    widget.isThereCard(true);
                                  }
                                  Get.back();
                                },
                                child: Container(
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
                                    leading: widget.isPlace
                                        ? Icon(
                                            Icons.location_on_sharp,
                                            color: Color(0xFF8E8EA9),
                                            size: 24.sp,
                                          )
                                        : SvgPicture.asset(
                                            'assets/icons/Credit-Card.svg',
                                            width: 24.w,
                                            height: 24.h,
                                          ),
                                    title: Text(
                                      widget.isPlace ? 'Home' : 'Nawar Al-Tibi',
                                      style: AppTextStyles.language.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF8E8EA9)),
                                    ),
                                  ),
                                ),
                              ),
                              index < 2
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 8.h),
                                      child: Divider(
                                        color: Color(0xFFEAEAEF),
                                        thickness: 2,
                                      ),
                                    )
                                  : Container()
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomBlackButton(
                        buttonText: 'add'.tr,
                        onPressed: () {
                          Get.toNamed(
                              widget.isPlace ? '/AddAddress' : '/NewCard');
                        })
                  ],
                ),
              ),
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
          child: widget.isAdd
              ? Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.primary,
                      size: 23.sp,
                    ),
                    widget.isPlace
                        ? Text(
                            ' Add a place'.tr,
                            style: AppTextStyles.language.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                          )
                        : Text(
                            ' Add a payment method'.tr,
                            style: AppTextStyles.language.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                          ),
                  ],
                )
              : Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: AppColors.primary,
                      size: 23.sp,
                    ),
                    widget.isPlace
                        ? Text(
                            ' Change the place'.tr,
                            style: AppTextStyles.language.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                          )
                        : Text(
                            ' Change payment method'.tr,
                            style: AppTextStyles.language.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                          ),
                  ],
                )),
    );
  }
}
