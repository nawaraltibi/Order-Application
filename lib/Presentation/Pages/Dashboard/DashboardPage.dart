import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                // HomePage(),
                // NewsPage(),
                // AlertsPage(),
                // AccountPage(),
              ],
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: AppColors.dark,
              selectedItemColor: AppColors.primary,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              selectedLabelStyle: AppTextStyles.language,
              unselectedLabelStyle: AppTextStyles.language,
              items: [
                _bottomNavigationBarItem(
                  isSelected: controller.tabIndex == 0,
                  icon: 'assets/icons/Home.svg',
                  iconS: 'assets/icons/HomeS.svg',
                  label: 'Home'.tr,
                ),
                _bottomNavigationBarItem(
                  isSelected: controller.tabIndex == 1,
                  icon: 'assets/icons/Search.svg',
                  iconS: 'assets/icons/SearchS.svg',
                  label: 'Search'.tr,
                ),
                _bottomNavigationBarItem(
                  isSelected: controller.tabIndex == 2,
                  icon: 'assets/icons/Orders.svg',
                  iconS: 'assets/icons/OrdersS.svg',
                  label: 'Orders'.tr,
                ),
                _bottomNavigationBarItem(
                  isSelected: controller.tabIndex == 3,
                  icon: 'assets/icons/Profile.svg',
                  iconS: 'assets/icons/ProfileS.svg',
                  label: 'Profile'.tr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({
    required bool isSelected,
    required String icon,
    required String iconS,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: isSelected ? 1.1 : 1, end: isSelected ? 1.1 : 1),
        duration: Duration(milliseconds: 300),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: SvgPicture.asset(
              isSelected ? iconS : icon,
              width: 24.w,
              height: 24.w,
            ),
          );
        },
      ),
      label: label,
    );
  }
}
