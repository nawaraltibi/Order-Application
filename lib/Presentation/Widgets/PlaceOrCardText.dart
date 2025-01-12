import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:order_application/Presentation/Controllers/Cart/CartController.dart';
import 'package:order_application/Presentation/Controllers/Profile/ProfileController.dart';
import 'package:order_application/Presentation/Controllers/User/UserController.dart';
import '../../App/Color/Color.dart';
import '../../App/Styles/AppTextStyles.dart';
import 'CustomBlackButton.dart';
import 'SectionTitle.dart';
import 'package:order_application/Data/Models/Location.dart';

class PlaceOrCardText extends StatefulWidget {
  final bool isAdd;
  final bool isPlace;

  PlaceOrCardText({
    required this.isAdd,
    required this.isPlace,
    super.key,
  });

  @override
  State<PlaceOrCardText> createState() => _PlaceOrCardTextState();
}

class _PlaceOrCardTextState extends State<PlaceOrCardText> {
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().getAllCards();
    Get.find<ProfileController>().getAllAddress();
    return InkWell(
      onTap: () {
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
                    SectionTitle(
                      text: widget.isPlace
                          ? 'Available locations:'.tr
                          : 'Available cards:'.tr,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                          () => widget.isPlace
                          ? _userController.user.value.locations == null
                          ? Center(child: CircularProgressIndicator())
                          : _buildLocationList()
                          : _userController.user.value.cards == null
                          ? Center(child: CircularProgressIndicator())
                          : _buildCardList(),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomBlackButton(
                      buttonText: widget.isPlace ? 'Add location'.tr : 'Add card'.tr,
                      onPressed: () {
                        Get.toNamed(widget.isPlace ? '/AddAddress' : '/NewCard');
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        child: widget.isAdd
            ? Row(
          children: [
            Icon(
              Icons.add,
              color: AppColors.primary,
              size: 23.sp,
            ),
            widget.isPlace
                ? Text(
              ' Add a place'.tr,
              style: AppTextStyles.language.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.primary,
              ),
            )
                : Text(
              ' Add a payment method'.tr,
              style: AppTextStyles.language.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.primary,
              ),
            ),
          ],
        )
            : Row(
          children: [
            Icon(
              Icons.edit,
              color: AppColors.primary,
              size: 23.sp,
            ),SizedBox(
              width: 220.w,
              child: widget.isPlace
                  ? Text(
                ' Change the place'.tr,
                style: AppTextStyles.language.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.primary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
                  : Text(
                ' Change payment method'.tr,
                style: AppTextStyles.language.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.primary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationList() {
    final CartController cartController = Get.find<CartController>();
    return Container(
      height: 260.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _userController.user.value.locations!.length,
        itemBuilder: (context, index) {
          Location location = _userController.user.value.locations![index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  cartController.currentCart.value.location = location;
                  cartController.currentCart.refresh();
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
        },
      ),
    );
  }

  Widget _buildCardList() {
    final CartController cartController = Get.find<CartController>();
    return Container(
      height: 260.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _userController.user.value.cards!.length,
        itemBuilder: (context, index) {
          var card = _userController.user.value.cards![index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  cartController.currentCart.value.card = card;
                  cartController.currentCart.refresh();
                  Get.back();
                },
                child: _buildListItem(
                  icon: Icons.credit_card,
                  text: card.name,
                ),
              ),
              if (index < _userController.user.value.cards!.length - 1)
                _buildDivider(),
            ],
          );
        },
      ),
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
}
