import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeToDeleteWidget extends StatefulWidget {
  final Widget child;
  final Future<bool> Function() onSwipe;  // Change to return Future<bool>
  final int height;

  const SwipeToDeleteWidget({
    Key? key,
    required this.child,
    required this.onSwipe,
    required this.height,
  }) : super(key: key);

  @override
  _SwipeToDeleteWidgetState createState() => _SwipeToDeleteWidgetState();
}

class _SwipeToDeleteWidgetState extends State<SwipeToDeleteWidget>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _childWidth = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _animateTo(double targetPosition) {
    _animation = Tween<double>(begin: _dragPosition, end: targetPosition).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    )..addListener(() {
      setState(() {
        _dragPosition = _animation.value;
      });
    });

    _animationController.forward(from: 0).then((_) {
      if (targetPosition == -_childWidth) {
        _deleteItem();
      }
    });
  }

  Future<void> _deleteItem() async {
    bool success = await widget.onSwipe();  // Call the onSwipe function and check success
    if (!success) {
      // If delete fails, revert the swipe action
      _animateTo(0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _childWidth = constraints.maxWidth;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Background delete container
            Container(
              height: widget.height.h,
              width: _childWidth,  // Match the child's width
              decoration: BoxDecoration(
                color: const Color(0xFF96293a),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
            // Foreground swipeable widget
            Positioned(
              left: _dragPosition,
              right: -_dragPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragPosition = (_dragPosition + details.delta.dx)
                        .clamp(-_childWidth, 0);  // Limit drag to child width
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (_dragPosition < -100) {
                    _animateTo(-_childWidth);  // Animate to full width
                  } else {
                    _animateTo(0);  // Revert if swipe is not enough
                  }
                },
                child: widget.child,
              ),
            ),
          ],
        );
      },
    );
  }
}