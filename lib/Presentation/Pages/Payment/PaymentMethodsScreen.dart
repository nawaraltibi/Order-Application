import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';

import '../../Widgets/PaymentCardWidget.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'payment'.tr,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 23.w),
        child: ListView(
          children: [
            SectionTitle(
              text: 'payment_cards'.tr,
            ),
            SizedBox(height: 28.h,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) => Padding(
                padding:  EdgeInsets.only(bottom: 22.h),
                child: SwipeToDeleteWidget(child: PaymentCardWidget(name: 'Name on card'),onSwipe: (){},),
              ),
            ),
            SizedBox(height: 20.h,),
            CustomBlackButton(buttonText: "add", onPressed: (){
              Get.toNamed('NewCard');
            })
          ],
        ),
      ),
    );
  }
}

