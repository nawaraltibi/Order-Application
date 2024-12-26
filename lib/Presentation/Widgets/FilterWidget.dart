import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_application/App/Color/Color.dart';
import 'package:order_application/App/Styles/AppTextStyles.dart';
import 'package:order_application/Data/Models/SearchType.dart';
import 'package:get/get.dart';

class FilterWidget extends StatefulWidget {
  final List<SearchType> filters;
  final Function(SearchType) onFilterChanged;

  FilterWidget({required this.filters, required this.onFilterChanged});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  SearchType selectedFilter = SearchType.products;

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

  Widget buildFilterButton(SearchType filter) {
    final isSelected = selectedFilter == filter;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
        widget.onFilterChanged(filter);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.dark : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          _getFilterLabel(filter),
          style: AppTextStyles.language.copyWith(
            color: isSelected ? Colors.white : AppColors.dark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getFilterLabel(SearchType filter) {
    switch (filter) {
      case SearchType.products:
        return 'products'.tr;
      case SearchType.markets:
        return 'markets'.tr;
      }
  }
}
