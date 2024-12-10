import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';

class FilterWidget extends StatefulWidget {
  final List<String> filters;

  FilterWidget({required this.filters});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String selectedFilter = '';

  @override
  void initState() {
    super.initState();
    if (widget.filters.isNotEmpty) {
      selectedFilter = widget.filters[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.filters.map((filter) => buildFilterButton(filter)).toList(),
    );
  }

  Widget buildFilterButton(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.dark : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.language.copyWith(
            color: isSelected ? Colors.white : AppColors.dark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
