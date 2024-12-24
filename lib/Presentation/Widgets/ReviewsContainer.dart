import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';

class ReviewsContainer extends StatelessWidget {
  double rating;
  int reviews;

  ReviewsContainer({
    required this.rating,
    required this.reviews,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            '$rating($reviews)',
            style: AppTextStyles.language
                .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
