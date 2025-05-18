import 'package:blinqo/features/role/event_planner/home/wigate/venue_compare_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Custom dialog widget with animated entrance and exit
class AnimatedVenueCompareDialog extends StatefulWidget {
  const AnimatedVenueCompareDialog({super.key});

  @override
  State<AnimatedVenueCompareDialog> createState() =>
      _AnimatedVenueCompareDialogState();
}

class _AnimatedVenueCompareDialogState extends State<AnimatedVenueCompareDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Offscreen right
      end: Offset(0.0, 0.0), // Center-right
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    if (mounted) Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: _dismiss, // Play reverse animation, then pop
            child: Container(color: Colors.black54),
          ),
        ),
        Positioned(
          top: 120,
          right: 0,
          child: SlideTransition(
            position: _animation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(minWidth: 250, minHeight: 200),
                child: VenueComparePopup(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
