import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Widgets/AddressCardWidget.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';
import 'package:order_application/Presentation/Widgets/SwipeToDeleteWidget.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "addresses".tr,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Align(child: SectionTitle(text: 'your_addresses'.tr),alignment: AlignmentDirectional.centerStart,),
            SizedBox(height: 20.h,),
            Expanded(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(bottom: 25.h),
                      child: SwipeToDeleteWidget(child: AddressCardWidget(
                        type: 'Work',
                        address: 'Al-Muhajireen',
                        details: 'Shamsiya',
                      ), onSwipe: (){}),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 30.h),
              child: CustomBlackButton(buttonText: 'add'.tr, onPressed: (){
                Get.toNamed('/AddAddress');
              }),
            )
          ],
        )
        ),
      );
  }
}
