import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToggleFavoriteButton extends StatefulWidget {
  final Function(bool) onChanged;
  final bool isFavorite;

  const ToggleFavoriteButton({
    Key? key,
    required this.onChanged,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  _ToggleFavoriteButtonState createState() => _ToggleFavoriteButtonState();
}

class _ToggleFavoriteButtonState extends State<ToggleFavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
        widget.onChanged(isFavorite);
      },
      child: Container(
        width: 25.w,
        height: 25.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: SvgPicture.asset(
          isFavorite
              ? "assets/icons/Like.svg"
              : "assets/icons/Dislike.svg",
          width: 20.w,
          height: 20.h,
        ),
      ),
    );
  }
}
