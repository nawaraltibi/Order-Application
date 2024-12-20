import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomTextField.dart';

import '../../Widgets/CustomAppBar.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  // Controllers for the text fields
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  // Variables to hold the dynamic text
  String cardNumber = "XXXX XXXX XXXX XXXX";
  String cardName = "Name on card";
  String expiryDate = "Expiry date";

  @override
  void initState() {
    super.initState();

    // Adding listeners to update the UI
    cardNumberController.addListener(() {
      setState(() {
        cardNumber = cardNumberController.text.isEmpty
            ? "XXXX XXXX XXXX XXXX"
            : cardNumberController.text;
      });
    });

    nameController.addListener(() {
      setState(() {
        cardName = nameController.text.isEmpty
            ? "Name on card".tr
            : nameController.text;
      });
    });

    expiryDateController.addListener(() {
      setState(() {
        expiryDate = expiryDateController.text.isEmpty
            ? "Expiry date".tr
            : expiryDateController.text;
      });
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    cardNumberController.dispose();
    nameController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'payment'.tr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 5
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/big-card.svg',
                    height: 210.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 90.h), // Add padding if needed
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        cardNumber,
                        style: AppTextStyles.language.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center, // Ensure the text is centered
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 39.w,
                  top: 150.h,
                  child: buildText(cardName, 15),
                ),
                Positioned(
                  left: 185.w,
                  top: 150.h,
                  child: buildText(expiryDate, 15),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            CustomTextField(
              hintText: 'Card number'.tr,
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: SvgPicture.asset(
                  "assets/icons/two-circles.svg",
                  width: 32.w,
                  height: 23.h,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            CustomTextField(
              hintText: 'Name on card'.tr,
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Expiry date'.tr,
                    controller: expiryDateController,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: CustomTextField(
                    hintText: 'CVC',
                    controller: TextEditingController(),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35.h,),
            CustomBlackButton(buttonText: 'Register'.tr, onPressed: (){})
          ],
        ),
      ),
    );
  }

  Text buildText(String text, int size) {
    return Text(
      '$text'.tr,
      style: AppTextStyles.language.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: size.sp,
        color: Colors.white,
      ),
    );
  }
}
