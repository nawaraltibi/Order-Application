import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeToDeleteWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipe;

  const SwipeToDeleteWidget({
    Key? key,
    required this.child,
    required this.onSwipe,
  }) : super(key: key);

  @override
  _SwipeToDeleteWidgetState createState() => _SwipeToDeleteWidgetState();
}

class _SwipeToDeleteWidgetState extends State<SwipeToDeleteWidget>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticIn,
      ),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 108.h,
          decoration: BoxDecoration(
            color: const Color(0xFF96293a),
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 5),
            ],
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 30,
          ),
        ),
        Positioned(
          left: _dragPosition + (_shakeAnimation.value * (_dragPosition < -100 ? 1 : 0)),
          right: -_dragPosition,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragPosition = (_dragPosition + details.delta.dx)
                    .clamp(-MediaQuery.of(context).size.width, 0);
              });
            },
            onHorizontalDragEnd: (details) {
              if (_dragPosition < -100) {
                _animationController
                    .forward()
                    .then((value) => _animationController.reverse());
              }
              if (_dragPosition < -100 && details.velocity.pixelsPerSecond.dx.abs() < 50) {
                widget.onSwipe();
              }
              setState(() {
                _dragPosition = 0;
              });
            },
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
