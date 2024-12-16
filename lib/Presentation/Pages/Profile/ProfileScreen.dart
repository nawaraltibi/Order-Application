import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/Dashboard/DashboardController.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';

class ProfileScreen extends GetView<ProfileController> {
  final List<Map> list = [
    {'icon': 'assets/icons/Notification.svg', 'text': 'Notification'},
    {'icon': 'assets/icons/Address.svg', 'text': 'Addresses'},
    {'icon': 'assets/icons/Payment.svg', 'text': 'Payment methods'},
    {'icon': 'assets/icons/Favorite.svg', 'text': 'My favorites'},
    {'icon': 'assets/icons/Language.svg', 'text': 'Language'},
    {'icon': 'assets/icons/About.svg', 'text': 'About'},
    {'icon': 'assets/icons/Logout.svg', 'text': 'Logout'},
  ];

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Profile'.tr,
          controller: Get.find<DashboardController>(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              image: AssetImage('assets/images/User.png'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 19.w,
                    ),
                    Column(
                      children: [
                        Text(
                          "Nawar Altibi",
                          style: AppTextStyles.language.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "(228) 90 21 21 14",
                          style: AppTextStyles.language.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 75.w,
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
              SvgPicture.asset(
                'assets/images/Profile Experience.svg',
                height: 100.h,
                width: 323.w,
              ),
              SizedBox(
                height: 18.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text("General".tr,
                    style: AppTextStyles.language.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF666687))),
              ),
              SizedBox(
                height: 12.h,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
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
                            Spacer(),
                            SvgPicture.asset(
                              'assets/icons/arrow-right-card.svg',
                              width: 22.w,
                              height: 22.h,
                            )
                          ],
                        ),
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
