import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import '../../../App/Styles/AppTextStyles.dart';

class EditOrderScreen extends GetView<OrdersController> {
  const EditOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Modify order'.tr),
        body: Center(
          child: Text(
            'Edit Order',
            style: AppTextStyles.language
                .copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
        ));
  }
}
