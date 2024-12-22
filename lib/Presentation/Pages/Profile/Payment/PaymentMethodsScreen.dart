import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';

import '../../../Widgets/PaymentCardWidget.dart';


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
          padding:  EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Align(child: SectionTitle(text: 'payment_cards'.tr),alignment: AlignmentDirectional.centerStart,),
              SizedBox(height: 20.h,),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: EdgeInsets.only(bottom: 25.h),
                        child: SwipeToDeleteWidget(child: PaymentCardWidget(
                          name: "Nawar",
                        ), onSwipe: (){

                        }),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(bottom: 30.h),
                child: CustomBlackButton(buttonText: 'add'.tr, onPressed: (){Get.toNamed('/NewCard');}),
              )
            ],
          )
      ),
    );
  }
}

