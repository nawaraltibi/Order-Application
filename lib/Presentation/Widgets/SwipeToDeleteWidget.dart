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
  late Animation<double> _animation;

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
      if (targetPosition == -MediaQuery.of(context).size.width) {
        widget.onSwipe();
      }
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
          left: _dragPosition,
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
                _animateTo(-MediaQuery.of(context).size.width);
              } else {
                _animateTo(0);
              }
            },
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
