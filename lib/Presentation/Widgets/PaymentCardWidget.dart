import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../App/Styles/AppTextStyles.dart';

class PaymentCardWidget extends StatelessWidget {
  String name = 'Name on card';
  PaymentCardWidget({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: 330.w,
      height: 108.h,
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 41.6.h,
            decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10.w)
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/card-icon.svg',
                fit: BoxFit.contain,
                width: 45.w,
                height: 28.h,
              ),
            ),
          ),
          SizedBox(width: 18.w,),
          Flexible(  // Wrap Text with Flexible
            child: Text(
              '$name',
              style: AppTextStyles.language.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Color(0xFF8E8EA9)
              ),
              overflow: TextOverflow.ellipsis,  // Handle overflow
              maxLines: 1,  // Limit to one line
            ),
          )
        ],
      ),
    );
  }
}
