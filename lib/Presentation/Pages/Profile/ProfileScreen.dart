import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Const/Host.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import 'package:order_application/Presentation/Widgets/CustomAlertDialog.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';

class ProfileScreen extends GetView<ProfileController> {
  final List<Map> list = [
    {
      'icon': 'assets/icons/Notification.svg',
      'text': 'notification'.tr,
      'root': ''
    },
    {
      'icon': 'assets/icons/Address.svg',
      'text': 'addresses'.tr,
      'root': 'Addresses'
    },
    {
      'icon': 'assets/icons/Payment.svg',
      'text': 'payment'.tr,
      'root': 'Payment'
    },
    {
      'icon': 'assets/icons/Favorite.svg',
      'text': 'favorites'.tr,
      'root': 'Favorites'
    },
    {
      'icon': 'assets/icons/Language.svg',
      'text': 'language'.tr,
      'root': 'Language'
    },
    {'icon': 'assets/icons/About.svg', 'text': 'about'.tr, 'root': 'About'},
    {'icon': 'assets/icons/Logout.svg', 'text': 'logout'.tr, 'root': 'logout'},
  ];

  bool isRTL = Get.locale?.languageCode == 'ar';

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Profile'.tr,
          controller: Get.find<DashboardController>(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: ListView(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Get.toNamed("/EditInformation");
                },
                child: Row(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://$host2/images/${Get.find<UserController>().user.value.imageName}'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 19.w,
                    ),
                    SizedBox(
                      width: 150.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Get.find<UserController>().user.value.name ??
                                "Guest",
                            style: AppTextStyles.language.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "(${Get.find<UserController>().user.value.phone ?? " "})",
                            style: AppTextStyles.language.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                              color: Colors.grey[500],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary, shape: BoxShape.circle),
                      width: 42.w,
                      height: 42.h,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/Edit.svg",
                          width: 21.w,
                          height: 21.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 323.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(16.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.h),
                      child: Text("experience".tr,
                          style: AppTextStyles.language.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(isRTL ? 3.1416 : 0),
                      child: ClipRRect(
                        child: SvgPicture.asset(
                          'assets/images/Profile Experience.svg',
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(16.w)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text("general".tr,
                    style: AppTextStyles.language.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF666687))),
              ),
              SizedBox(
                height: 12.h,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      if (list[index]['root'] != 'logout') {
                        Get.toNamed("/${list[index]['root']}");
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              message: 'are you sure you want to log out?'.tr,
                              onConfirm: () {
                                controller.logoutUser();
                              },
                              onCancel: () {
                                Get.back();
                              },
                              confirmText: 'logout'.tr,
                              cancelText: 'cancel'.tr,
                            );
                          },
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 11, bottom: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            list[index]['icon'],
                            width: 26.w,
                            height: 26.h,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            '${list[index]['text']}'.tr,
                            style: AppTextStyles.language.copyWith(
                                fontSize: 15.sp, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(isRTL ? 3.1416 : 0),
                            child: SvgPicture.asset(
                              'assets/icons/arrow-right-card.svg',
                              width: 22.w,
                              height: 22.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
