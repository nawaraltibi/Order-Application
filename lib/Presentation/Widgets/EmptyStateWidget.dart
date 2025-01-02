import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/EmptyState.dart';

class EmptyStateWidget extends StatelessWidget {
  final EmptyState state;
  final VoidCallback? onRetry;

  const EmptyStateWidget({
    Key? key,
    required this.state,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String assetPath = '';
    String message = '';

    switch (state) {
      case EmptyState.noResults:
        assetPath = 'assets/images/no_results.svg';
        message = 'no_results'.tr;
        break;
      case EmptyState.searchPrompt:
        assetPath = 'assets/images/search_prompt.svg';
        message = 'search_prompt'.tr;
        break;
      case EmptyState.noLocation:
        assetPath = 'assets/images/no_location.svg';
        message = 'no_location'.tr;
        break;
      case EmptyState.noBankCard:
        assetPath = 'assets/images/no_bank_card.svg';
        message = 'no_bank_card'.tr;
        break;
      case EmptyState.noFavorites:
        assetPath = 'assets/images/no_favorites.svg';
        message = 'no_favorites'.tr;
        break;
      case EmptyState.error:
        assetPath = 'assets/images/error.svg';
        message = 'error'.tr;
        break;
      case EmptyState.noNetwork:
        assetPath = 'assets/images/no_network.svg';
        message = 'no_network'.tr;
        break;
      case EmptyState.noOrders:
        assetPath = 'assets/images/no_orders.svg';
        message = 'Nothing is available now. Click on the Get Current Location button to update and get the list of requests.';
      default:
        assetPath = 'assets/images/default_empty.svg';
        message = 'default_empty'.tr;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          assetPath,
          height: 150.h,
          width: 150.w,
        ),
        SizedBox(height: 20.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.language.copyWith(
              fontSize: 16.sp, color: Colors.grey
          ),
        ),
        if (onRetry != null) ...[
          SizedBox(height: 15.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'retry'.tr,
                style: AppTextStyles.language.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
            ),
          ),
        ],
      ],
    );
  }
}