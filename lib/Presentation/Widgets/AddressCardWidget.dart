import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Color/Color.dart';

import '../../App/Styles/AppTextStyles.dart';

class AddressCardWidget extends StatelessWidget {
  String type;
  String address;
  String details;
  AddressCardWidget({
    required this.type,
    required this.address,
    required this.details,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:18.h,horizontal: 18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: 330.w,
      height: 108.h,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              type,
              style: AppTextStyles.language.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.dark,
              ),
            ),
            VerticalDivider(
              color: Color(0xFFDCDCE4),
              thickness: 1.4,
              width: 30.w,
              indent: 7.h,
              endIndent: 7.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address,
                      style: AppTextStyles.language.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8E8EA9),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      details,
                      style: AppTextStyles.language.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8E8EA9),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )


    );
  }
}
