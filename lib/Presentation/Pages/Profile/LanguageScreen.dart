import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:order_application/Presentation/Controllers/Language/LanguageController.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomRadioListTile.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedLanguageCode;
    String? selectedCountryCode;

    return Scaffold(
        appBar: CustomAppBar(title: 'language'.tr),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: ListView(
            children: [
              SectionTitle(text: 'your Language'.tr),
              SizedBox(
                height: 18.h,
              ),
              CustomRadioListTile(
                list: [
                  {
                    'title': 'English',
                    'languageCode': 'en',
                    'countryCode': 'US'
                  },
                  {
                    'title': 'Arabic',
                    'languageCode': 'ar',
                    'countryCode': 'SA'
                  },
                ],
                onSelected: (selected) {
                  selectedLanguageCode = selected['languageCode']!;
                  selectedCountryCode = selected['countryCode']!;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomBlackButton(
                  buttonText: "apply".tr,
                  onPressed: () {
                    controller.changeLanguage(
                      selectedLanguageCode!,
                      selectedCountryCode!,
                    );
                    Get.back();
                  })
            ],
          ),
        ));
  }
}
