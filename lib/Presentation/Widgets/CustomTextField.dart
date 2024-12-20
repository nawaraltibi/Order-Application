import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator; // Optional validator for validation
  final String? hintText; // Optional hint text
  final Widget? suffixIcon; // Optional suffix icon (image or icon)
  final TextInputType keyboardType; // To accept different types of keyboard input

  // Constructor accepting the controller, optional validator, hintText, suffixIcon, and keyboardType
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText = '',
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // Determine text alignment based on the current language direction
    TextAlign textAlign = Get.locale?.languageCode == 'ar' ? TextAlign.right : TextAlign.left;

    return TextFormField(
      controller: controller, // Set the controller to manage the input
      keyboardType: keyboardType, // Use the keyboard type passed in the constructor
      validator: validator, // Use validator if provided
      decoration: InputDecoration(
        hintText: hintText, // Optional hint text
        hintStyle: AppTextStyles.language.copyWith(
          fontSize: 16.sp,
          color: Color(0xFF8E8EA9),
          fontWeight: FontWeight.w300,
        ),
        fillColor: Colors.white, // Set the background color to white
        filled: true, // Enable filling the background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Color(0xFFEAEAEF),
            width: 1.5, // Reduced border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Color(0xFFEAEAEF),
            width: 1.5, // Reduced border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Color(0xFFEAEAEF),
            width: 1.5, // Reduced border width
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: true,
        suffixIcon: suffixIcon, // Optional suffix icon (can be an image or icon)
      ),
      style: AppTextStyles.language.copyWith(
        fontSize: 16.sp,
        color: Colors.black,
        fontWeight: FontWeight.w300,
      ),
      textAlign: textAlign, // Change text alignment based on the language
    );
  }
}
