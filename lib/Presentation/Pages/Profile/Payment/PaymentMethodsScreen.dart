import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';
import '../../../Widgets/PaymentCardWidget.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';

class PaymentMethodsScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    controller.getAllCards();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'payment'.tr,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Align(
                child: SectionTitle(text: 'payment_cards'.tr),
                alignment: AlignmentDirectional.centerStart,
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Obx(() {
                  final cards =
                      Get.find<UserController>().user.value.cards ?? [];
                  final isLoading =
                      controller.loadingMap['getAllAddress']?.value;
                  if (isLoading!) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (cards.isEmpty) {
                    return Center(
                      child: Text(
                        "no_cards".tr,
                        style: AppTextStyles.language.copyWith(
                            fontSize: 16.sp, color: Colors.grey
                        ),                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 25.h),
                        child: SwipeToDeleteWidget(
                          height: 108,
                          child: PaymentCardWidget(
                            name: card.name,
                          ),
                          onSwipe: () {
                            controller.deleteAnCards(card.id!);
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: CustomBlackButton(
                    buttonText: 'add'.tr,
                    onPressed: () {
                      Get.toNamed('/NewCard');
                    }),
              )
            ],
          )),
    );
  }
}
