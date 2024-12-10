import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOTPField extends StatefulWidget {
  final TextEditingController controller;
  // final String? Function(String?)? validator;
  final TextInputType keyboard;

  const CustomOTPField({
    super.key,
    // required this.validator,
    required this.controller,
    required this.keyboard,
  });

  @override
  CustomOTPFieldState createState() => CustomOTPFieldState();
}

class CustomOTPFieldState extends State<CustomOTPField> {
  String? code;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      controller: widget.controller,
      keyboardType: widget.keyboard,
      cursorColor: Colors.black,
      animationType: AnimationType.fade,
      textStyle: AppTextStyles.language.copyWith(
          color: Color(0xff4a4a68),
          fontWeight: FontWeight.w700
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderWidth: 0.1.h,
        borderRadius: BorderRadius.circular(16.r),
        fieldHeight: 54.w,
        fieldWidth: 54.h,
        inactiveColor: Color(0xffeaeaef),
        activeColor: Color(0xffeaeaef),
        selectedColor: Color(0xffF19434),
        inactiveFillColor: Colors.white,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 10.w),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      onChanged: (value) {
        print(value);
      },
      onCompleted: (value) {
        setState(() {
          code = value;
        });
      },
    );
  }
}
