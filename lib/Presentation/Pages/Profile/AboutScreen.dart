import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/Presentation/Widgets/CustomAppBar.dart';
import 'package:order_application/Presentation/Widgets/CustomBlackButton.dart';
import 'package:order_application/Presentation/Widgets/SectionTitle.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About'),
      body: Padding(
        padding: EdgeInsets.only(right: 23.w,left: 23.w,bottom: 35.h),
        child: Column(
          children: [
            const Align(alignment: AlignmentDirectional.centerStart,child: SectionTitle(text: 'About us:'),),
            Expanded(
              child: ListView(
                children: const [
                  Text('')
                ],
              ),
            ),
            CustomBlackButton(buttonText: 'Ok', onPressed: (){Navigator.pop(context);})
          ],
        ),
      ),
    );
  }
}
