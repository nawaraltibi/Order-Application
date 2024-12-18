import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';

class PriceText extends StatelessWidget {
  final double price;
  final int size;
  const PriceText({
    required this.price,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$price',
            style: AppTextStyles.language.copyWith(
              color: AppColors.primary,
              fontSize: size.sp,
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
    );
  }
}