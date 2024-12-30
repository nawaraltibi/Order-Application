import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Const/Host.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Controllers/Cart/CartController.dart';
import 'package:order_application/Presentation/Controllers/Home/HomeController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import '../../Widgets/ShoppingCartContainer.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(18.0.w, 0, 18.0.w, 0),
        child: ListView(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 60.h,
              ),
              Obx((){
                return Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Get.find<UserController>().user.value.name ?? "Guest",
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
                );
              }),
              SizedBox(
                height: 30.h,
              ),
              Obx((){
                print(Get.find<CartController>().currentCart.value.toJson());
                return ShoppingCartContainer(
                  isShow: !Get.find<CartController>().isCartEmpty(),
                  price: Get.find<CartController>().currentCart.value.totalCost!.toInt(),
                );
              }),
              SectionTitle(text: 'Most Requested:'.tr),
              SizedBox(
                height: 20.h,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
