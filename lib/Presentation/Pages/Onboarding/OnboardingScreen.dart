import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_application/Presentation/Widgets/OrangeButtonWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final List<Map> pages = [
    {
      'image': 'assets/images/onboarding/Peace.png',
      'description': 'Discover Local Stores and Products at Your Fingertips!',
      'width': 160.36.w,
      'height': 198.37.h,
      'top': 195.5.h,
      'left': 99.76.w
    },
    {
      'image':
          'assets/images/onboarding/3d-casual-life-delivery-boy-on-scooter-1 1.png',
      'description': 'Fast and Reliable Delivery to Your Doorstep.',
      'width': 176.33.w,
      'height': 198.37.h,
      'top': 196.09.h,
      'left': 110.67.w
    },
    {
      'image': 'assets/images/onboarding/ThumbsUp.png',
      'description': 'Effortless Shopping with Personalized Features.',
      'width': 160.36.w,
      'height': 198.37.h,
      'top': 196.09.h,
      'left': 99.23.w
    },
  ];
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
    Positioned(
      left: -35.w,
      top: 112.h,
      child: Container(
        width: 430.w,
        height: 430.h,
        child: SvgPicture.asset(
          'assets/images/onboarding/Group 17593.svg',

        ),
      ),
    ),
    Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned(
                left: pages[index]['left'],
                top: pages[index]['top'],
                child: Container(
                  width: pages[index]['width'],
                  height: pages[index]['height'],
                  child: Image.asset(
                    pages[index]['image']!,
                  ),
                ),
              ),
              Positioned(
                top: 475.h,
                left: 24.w,
                child: Container(
                  width: 310.w,
                  height: 110.h,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${pages[index]['description']}'.tr,
                    style: GoogleFonts.mulish(
                        textStyle: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.w500)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
    Positioned(
      top: 600.h,
      left: 145.w,
      child: SmoothPageIndicator(
        controller: _pageController,
        count: 3,
        effect: ExpandingDotsEffect(
          dotHeight: 10,
          dotWidth: 10,
          expansionFactor: 4.5,
          activeDotColor: Color(0xFFF19434),
          dotColor: Color(0xFFD9D9D9),
        ),
      ),
    ),
    Positioned(
      left: 270.w,
      top: 670.h,
      child: OrangeButtonWidget(function: _nextPage),
    ),
    Positioned(
        left: 40.w,
        top: 675.h,
        child: TextButton(
            onPressed: () {},
            child: Text(
              "Skip".tr,
              style: GoogleFonts.mulish(
                  textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF8E8EA9),
                fontSize: 20.sp,
              )),
            ))),
          ]),
        );
  }
}
