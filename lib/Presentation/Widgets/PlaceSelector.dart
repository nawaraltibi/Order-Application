import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Cart/CartController.dart';
import 'package:order_application/Presentation/Controllers/Orders/OrdersController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import 'CustomBlackButton.dart';
import 'SectionTitle.dart';
import 'package:order_application/Data/Models/Location.dart';

class PlaceSelector extends StatefulWidget {

  @override
  State<PlaceSelector> createState() => _PlaceSelectorState();
}

class _PlaceSelectorState extends State<PlaceSelector> {
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPlaceDialog(context),
      borderRadius: BorderRadius.circular(16.r),
      child: _buildButtonContent(),
    );
  }

  void _showPlaceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(),
                SizedBox(height: 10.h),
                _buildLocationList(),
                SizedBox(height: 25.h),
                _buildAddLocationButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle() {
    return SectionTitle(
      text: 'Available locations:'.tr,
    );
  }

  Widget _buildButtonContent() {
    return  Row(
      children: [
        Icon(
          Icons.edit,
          color: AppColors.primary,
          size: 23.sp,
        ),
        Text(
          ' Change the place'.tr,
          style: AppTextStyles.language.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationList() {
    return Obx(
          () => _userController.user.value.locations == null
          ? Center(child: CircularProgressIndicator())
          : _buildLocationListView(),
    );
  }

  Widget _buildLocationListView() {
    final CartController cartController = Get.find<CartController>();
    return Container(
      height: 260.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _userController.user.value.locations!.length,
        itemBuilder: (context, index) {
          Location location = _userController.user.value.locations![index];
          return _buildLocationListItem(location, cartController, index);
        },
      ),
    );
  }

  Widget _buildLocationListItem(Location location, CartController cartController, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Get.find<OrdersController>().selectedOrder.value!.location = location;
            Get.find<OrdersController>().selectedOrder.refresh();
            Get.back();
          },
          child: _buildListItem(
            icon: Icons.location_on_sharp,
            text: location.name,
          ),
        ),
        if (index < _userController.user.value.locations!.length - 1)
          _buildDivider(),
      ],
    );
  }

  Widget _buildListItem({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Color(0xFFEAEAEF),
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Color(0xFF8E8EA9),
          size: 24.sp,
        ),
        title: Text(
          text,
          style: AppTextStyles.language.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8E8EA9),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      child: Divider(
        color: Color(0xFFEAEAEF),
        thickness: 2,
      ),
    );
  }

  Widget _buildAddLocationButton() {
    return CustomBlackButton(
      buttonText: 'Add location'.tr,
      onPressed: () {
        Get.toNamed('/AddAddress');
      },
    );
  }
}
