import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/CustomRadioListTile.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';

class Languagescreen extends StatefulWidget {
  const Languagescreen({super.key});

  @override
  State<Languagescreen> createState() => _LanguagescreenState();
}

class _LanguagescreenState extends State<Languagescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Language'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: ListView(
            children: [
              const SectionTitle(text: 'Your Language: '),
              SizedBox(
                height: 18.h,
              ),
              CustomRadioListTile(
                titles: ['English', 'Arabic'],
                onSelected: (val) {},
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomBlackButton(buttonText: "Apply", onPressed: () {})
            ],
          ),
        ));
  }
}
