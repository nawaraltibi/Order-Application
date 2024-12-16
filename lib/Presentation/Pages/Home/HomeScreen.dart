import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/Home/HomeController.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
        child: Column(children: [
          SizedBox(
            height: 50.h,
          ),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nawar Altibi",
                    style: AppTextStyles.language.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    'need'.tr,
                    style: AppTextStyles.language.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  )
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
