import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../App/Styles/AppTextStyles.dart';

class BlackPriceText extends StatelessWidget {
   var price;
  final int size;
   BlackPriceText({
    required this.price,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.ltr, // Force LTR direction
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$price',
              style: AppTextStyles.language.copyWith(
                color: Color(0xFF4A4A6A),
                fontSize: size.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(2, -5),
                child: Text(
                  '\$',
                  style: AppTextStyles.language.copyWith(
                    color: Color(0xFF4A4A6A),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}