import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrangeButtonWidget extends StatefulWidget {
  // Function parameter to support both sync and async functions
  final Function function;

  // A flag to determine if loading should be displayed
  final bool needsLoading;

  // Constructor with default value for 'needsLoading'
  const OrangeButtonWidget({
    super.key,
    required this.function, // The function to be called on button press
    this.needsLoading = false, // Default: doesn't need loading
  });

  @override
  _OrangeButtonWidgetState createState() => _OrangeButtonWidgetState();
}

class _OrangeButtonWidgetState extends State<OrangeButtonWidget> {
  // A variable to track loading state
  bool _isLoading = false;

  // Function to handle button press, showing loading if needed
  Future<void> _handleButtonPress() async {
    // If the function requires loading, show the loading spinner
    if (widget.needsLoading) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      // Execute the passed function
      var result = widget.function();

      // If the function is asynchronous, wait for its result
      if (result is Future) await result;
    } finally {
      // Hide the loading spinner after the function completes
      if (widget.needsLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.w, // Set the width dynamically using ScreenUtil
      height: 56.h, // Set the height dynamically using ScreenUtil
      child: ElevatedButton(
        // Disable the button when loading is true
        onPressed: _isLoading ? null : _handleButtonPress,

        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF19434), // Button's background color
          elevation: 2, // Button elevation for shadow effect
          padding: EdgeInsets.all(0), // Remove padding inside the button
        ),

        child: _isLoading
            // Show loading spinner if _isLoading is true
            ? SizedBox(
                width: 24.w, // Size of the loading spinner
                height: 24.h,
                child: CircularProgressIndicator(
                  color: Colors.white, // Color of the spinner
                  strokeWidth: 2.0, // Width of the spinner's stroke
                ),
              )
            // Show the arrow icon if not loading
            : SvgPicture.asset(
                'assets/images/arrow-right.svg', // Icon asset
                width: 24.89.w, // Dynamic width
                height: 24.89.h, // Dynamic height
              ),
      ),
    );
  }
}