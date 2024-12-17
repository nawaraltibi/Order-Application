import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

class CustomRadioListTile extends StatefulWidget {
  final List<dynamic> titles; // List of titles
  final Function(dynamic) onSelected; // Callback function

  const CustomRadioListTile({
    super.key,
    required this.titles,
    required this.onSelected,
  });

  @override
  _CustomRadioListTileState createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  dynamic selectedTitle; // Tracks the selected title

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.titles.length,
      itemBuilder: (context, index) {
        dynamic title = widget.titles[index];
        bool isSelected = selectedTitle == title;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.w),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.w),
            child: Material(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  '$title'.tr,
                  style: AppTextStyles.language.copyWith(
                      fontSize: 18.sp,
                      color: const Color(0xFF8E8EA9),
                      fontWeight: FontWeight.w600),
                ),
                leading: Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8E8EA9),
                      width: 2.w,
                    ),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedTitle = title; // Update selected value
                  });
                  widget.onSelected(title); // Call the callback function
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
